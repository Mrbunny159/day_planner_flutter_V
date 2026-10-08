import sys
import os
import json
from PyQt5.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QPushButton, QGraphicsView, QGraphicsScene,
    QGraphicsItem, QGraphicsTextItem, QDialog, QTimeEdit, QDialogButtonBox,
    QHBoxLayout, QComboBox, QLabel, QSizePolicy, QCheckBox, QGraphicsProxyWidget, QMenu, QAction, QMessageBox,
    QShortcut, QGraphicsSimpleTextItem, QRadioButton, QButtonGroup, QLineEdit,
    QColorDialog, QFormLayout, QGraphicsDropShadowEffect, QTextEdit, QPlainTextEdit, QSpinBox
)
from PyQt5.QtGui import (
    QBrush, QColor, QPainter, QPen, QFont, QPainterPath, QKeySequence, QFontMetrics, QTransform
)
from PyQt5.QtCore import Qt, QTime, QTimer, QRectF, QDate, QPointF, QPropertyAnimation, QEasingCurve, QVariantAnimation
from datetime import time



BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_FILE_PATH = os.path.join(BASE_DIR, "data.json")

COLOR_SCHEMES = {
    "Default": {
        "task_color": [60, 100, 200, 180],
        "task_border_color": [100, 150, 220],
        "break_color": [60, 120, 80, 180],
        "break_border_color": [100, 200, 120],
        "background_color": [240, 240, 240]
    },
    "Gray": {
        "task_color": [80, 80, 80, 200],
        "task_border_color": [120, 120, 120],
        "break_color": [60, 60, 60, 200],
        "break_border_color": [100, 100, 100],
        "background_color": [30, 30, 30]
    }
}



class QGraphicsCheckBox(QGraphicsProxyWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        checkbox = QCheckBox()
        checkbox.setStyleSheet("background-color: transparent;")
        self.setWidget(checkbox)
    def setChecked(self, state):
        self.widget().setChecked(state)

    def isChecked(self):
        return self.widget().isChecked()

    @property
    def stateChanged(self):
        return self.widget().stateChanged


class TimeSlotDialog(QDialog):
    DURATIONS = [15, 30, 45, 60, 90, 120, 150, 180]

    def __init__(self, current_duration=30, name="Untitled", block_type="task", recurring="none", parent=None):
        super().__init__(parent)
        self.setWindowTitle("Edit Block")
        layout = QVBoxLayout(self)

        # --- Name Input ---
        layout.addWidget(QLabel("Name"))
        self.name_input = QPlainTextEdit(name if name else "")
        self.name_input.setPlaceholderText("Enter one task per line")
        self.name_input.setFixedHeight(80)
        layout.addWidget(self.name_input)

        # --- Duration Dropdown ---
        layout.addWidget(QLabel("Duration"))
        self.duration_input = QComboBox()
        for d in self.DURATIONS:
            self.duration_input.addItem(f"{d} minutes", d)
        if current_duration in self.DURATIONS:
            self.duration_input.setCurrentIndex(self.DURATIONS.index(current_duration))
        layout.addWidget(self.duration_input)

        # --- Type (Task / Break) ---
        layout.addWidget(QLabel("Type"))
        self.task_radio = QRadioButton("Task")
        self.break_radio = QRadioButton("Break")
        self.type_group = QButtonGroup(self)
        self.type_group.addButton(self.task_radio)
        self.type_group.addButton(self.break_radio)
        layout.addLayout(self._hbox(self.task_radio, self.break_radio))

        if block_type == "break":
            self.break_radio.setChecked(True)
        else:
            self.task_radio.setChecked(True)

        # --- Repeat (None / Daily) ---
        layout.addWidget(QLabel("Repeat"))
        self.repeat_none_radio = QRadioButton("None")
        self.repeat_daily_radio = QRadioButton("Daily")
        self.repeat_group = QButtonGroup(self)
        self.repeat_group.addButton(self.repeat_none_radio)
        self.repeat_group.addButton(self.repeat_daily_radio)
        layout.addLayout(self._hbox(self.repeat_none_radio, self.repeat_daily_radio))

        if recurring == "daily":
            self.repeat_daily_radio.setChecked(True)
        else:
            self.repeat_none_radio.setChecked(True)

        # --- Start Time + +/- buttons ---
        self.start_label = QLabel("Start Time")
        layout.addWidget(self.start_label)

        self.start_time = QTimeEdit()
        self.start_time.setDisplayFormat("hh:mm AP")
        now = QTime.currentTime()
        next_15 = ((now.minute() + 14) // 15) * 15
        aligned = QTime(now.hour(), 0).addSecs(next_15 * 60)
        self.start_time.setTime(aligned)

        self.btn_minus = QPushButton("−")
        self.btn_minus.setFixedWidth(24)
        self.btn_plus = QPushButton("+")
        self.btn_plus.setFixedWidth(24)

        self.btn_minus.clicked.connect(lambda: self.adjust_time(-15))
        self.btn_plus.clicked.connect(lambda: self.adjust_time(15))

        time_row = QHBoxLayout()
        time_row.addWidget(self.start_time)
        time_row.addWidget(self.btn_minus)
        time_row.addWidget(self.btn_plus)
        layout.addLayout(time_row)

        # --- OK / Cancel buttons ---
        buttons = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        buttons.accepted.connect(self.accept)
        buttons.rejected.connect(self.reject)
        layout.addWidget(buttons)

        # --- Connect logic AFTER widgets created ---
        self.task_radio.toggled.connect(self.toggle_start_time_enabled)
        self.break_radio.toggled.connect(self.toggle_start_time_enabled)
        self.toggle_start_time_enabled()

    def toggle_start_time_enabled(self):
        is_break = self.break_radio.isChecked()
        self.start_label.setEnabled(is_break)
        self.start_time.setEnabled(is_break)
        self.btn_plus.setEnabled(is_break)
        self.btn_minus.setEnabled(is_break)

    def adjust_time(self, minutes):
        current = self.start_time.time()
        new_time = current.addSecs(minutes * 60)
        if new_time.isValid():
            self.start_time.setTime(new_time)




    def _hbox(self, *widgets):
        box = QHBoxLayout()
        for w in widgets:
            box.addWidget(w)
        return box


    def selected_type(self):
        return "break" if self.break_radio.isChecked() else "task"

    def selected_repeat(self):
        return "daily" if self.repeat_daily_radio.isChecked() else "none"


class TimeBlock(QGraphicsItem):
    def __init__(self, start_minute, duration, block_type='task', name='Untitled', completed=False, tag_color=None, recurring="none"):
        super().__init__()
        self.setFlags(QGraphicsItem.ItemIsSelectable | QGraphicsItem.ItemIsFocusable)
        self.proxy = None  # ✅ Prevent crashes when accessed later
        # --- Ensure we are working with integers ---
        assert isinstance(start_minute, int), f"start_minute must be int, got {type(start_minute)}"
        assert isinstance(duration, int), f"duration must be int, got {type(duration)}"
        self._suppress_updates = False
        self.start_minute = start_minute
        self.duration = duration
        self.block_type = block_type
        self.original_duration = self.get_duration_minutes()
        self.name = name
        self.completed = completed
        self.width = 360 if block_type == 'task' else 308
        self.color = QColor(60, 100, 200, 180) if block_type == 'task' else QColor(60, 120, 80, 180)
        self.base_color = QColor(60, 100, 200, 180) if block_type == "task" else QColor(60, 120, 80, 180)
        self.tag_color = tag_color
        self.recurring = recurring

        self.checkbox = None
        self._resizing = False
        self._resize_start_y = 0
        self._resize_start_duration = 0
        self._dragging = False
        self._drag_start_scene_y = 0
        self._drag_start_minute = 0
        self._conflict_flash = False
        self.setAcceptHoverEvents(True)
        self.setAcceptedMouseButtons(Qt.LeftButton | Qt.RightButton)

        # Duration pill
        self.duration_label = QGraphicsSimpleTextItem(self)
        font = QFont("Arial", 8)
        font.setBold(True)
        self.duration_label.setFont(font)
        self.duration_label.setBrush(Qt.white)

        self.update_geometry()
        if self.block_type == 'task':
            self.add_checkbox()

    def safe_remove_proxy(self, proxy):
        if proxy and proxy.scene() == self.scene():
            self.scene().removeItem(proxy)


    def get_duration_minutes(self):
        return self.duration


    def move_task_down(self):
        if self.block_type != 'task':
            return

        duration = self.get_duration_minutes()
        new_start, new_end = self.scene().parent_app.find_next_free_slot(duration)
        self.start = new_start
        self.end = new_end
        self.update_geometry()
        self.update()


    def format_time(self, minute):
        return f"{(minute // 60) % 24:02}:{minute % 60:02}"

    def to_qtime(self, minute):
        return QTime((minute // 60) % 24, minute % 60)

    def get_start_qtime(self):
        return self.to_qtime(self.start_minute)

    def get_end_qtime(self):
        return self.to_qtime(self.start_minute + self.duration)

    def delete_later(self):
        scene = self.scene()
        if scene and hasattr(scene, "parent_app"):
            self.safe_remove_item()
            scene.parent_app.save_all()


    def delete_all_completed(self):
        scene = self.scene()
        if scene and hasattr(scene, "parent_app"):
            for item in list(scene.items()):
                if hasattr(item, "completed") and item.completed and hasattr(item, "safe_remove_item"):
                    item.safe_remove_item()
            scene.parent_app.save_all()






    def contextMenuEvent(self, event):
        self.setSelected(True)
        menu = QMenu()
        scene = self.scene() if self.scene() else None

        # ✅ Declare all possible actions
        mark_complete_action = None
        mark_incomplete_action = None
        edit_action = None
        delete_action = None
        delete_all_action = None
        color_actions = {}

        if self.block_type == "break":
            edit_action = menu.addAction("Edit")
            delete_action = menu.addAction("Delete")
            action = menu.exec_(event.screenPos())

            if action == edit_action:
                self.mouseDoubleClickEvent(event)

            elif action == delete_action:
                if scene:
                    scene.parent_app.safe_remove_item(self)
                    scene.parent_app.save_all()

        else:
            if self.completed:
                mark_incomplete_action = menu.addAction("Mark as Incomplete")
                delete_action = menu.addAction("Delete")
                delete_all_action = menu.addAction("Delete all completed")
            else:
                mark_complete_action = menu.addAction("Mark as Complete")
                edit_action = menu.addAction("Edit")
                delete_action = menu.addAction("Delete")

                color_menu = menu.addMenu("Set Color Tag")
                colors = {
                    "None": None,
                    "Blue": QColor(60, 100, 200, 180),
                    "Green": QColor(60, 120, 80, 180),
                    "Orange": QColor(200, 120, 40, 180),
                    "Red": QColor(180, 60, 60, 180),
                }
                color_actions = {color_menu.addAction(name): color for name, color in colors.items()}

            action = menu.exec_(event.screenPos())
            if not action:
                return

            if self.completed:
                if action == mark_incomplete_action:
                    self.completed = False
                    if self.proxy:
                        self.proxy.widget().setChecked(False)
                    self.update_geometry()
                    if scene:
                        scene.parent_app.save_all()

                elif action == delete_action:
                    if scene:
                        self.safe_remove_proxy(self.proxy)
                        scene.parent_app.safe_remove_item(self)
                        scene.parent_app.save_all()

                elif action == delete_all_action:
                    if scene:
                        for item in scene.items():
                            if getattr(item, "completed", False):
                                if hasattr(item, "safe_remove_proxy"):
                                    item.safe_remove_proxy(getattr(item, "proxy", None))
                                scene.parent_app.safe_remove_item(item)
                        scene.parent_app.save_all()

            else:
                if action == mark_complete_action:
                    self.completed = True
                    if self.proxy:
                        self.proxy.widget().setChecked(True)
                    self.update_geometry()
                    if scene:
                        scene.parent_app.save_all()

                elif action == edit_action:
                    self.mouseDoubleClickEvent(event)

                elif action == delete_action:
                    if scene:
                        self.safe_remove_proxy(self.proxy)
                        scene.parent_app.safe_remove_item(self)
                        scene.parent_app.save_all()

                elif 'color_actions' in locals() and action in color_actions:
                    self.tag_color = color_actions[action]
                    self.update()
                    if scene:
                        scene.parent_app.save_all()





    def update_type(self, new_type):
        self.block_type = new_type
        self.width = 360 if new_type == 'task' else 308
        self.color = QColor(60, 100, 200, 180) if new_type == 'task' else QColor(60, 120, 80, 180)

        if new_type == 'break':
            if hasattr(self, "proxy") and self.proxy:
                self.safe_remove_proxy(self.proxy)
            self.proxy = None
            self.checkbox = None

        elif new_type == 'task' and not self.checkbox:
            self.add_checkbox()







    def add_checkbox(self):
        self.safe_remove_proxy(self.proxy)
        self.proxy = None

        checkbox = QCheckBox()
        checkbox.setChecked(self.completed)
        checkbox.stateChanged.connect(self.toggle_completed)

        self.proxy = QGraphicsProxyWidget(self)
        self.proxy.setWidget(checkbox)

        self.update_checkbox_position()




    def toggle_completed(self, state):
        self.completed = bool(state)
        self.update_geometry()

        # ✅ Safe scene check before saving
        if self.scene() and hasattr(self.scene(), 'parent_app'):
            self.scene().parent_app.save_all()

    def flash_conflict(self):
        """Briefly tint the block red to indicate it was displaced by a conflict."""
        self._conflict_flash = True
        self.update()
        QTimer.singleShot(600, self._clear_flash)

    def _clear_flash(self):
        self._conflict_flash = False
        self.update()


    def boundingRect(self):
        return QRectF(60, 0, self.width, self.height)




    def paint(self, painter, option, widget):
        painter.setRenderHint(QPainter.Antialiasing)

        # Fill color logic
        color = self.tag_color if self.tag_color else self.base_color
        painter.setBrush(QBrush(color))

        # Border color on hover or selected
        if self.isUnderMouse() or self.isSelected():
            pen = QPen(QColor("#FFD54F"), 2)
        else:
            pen = QPen(self.border_color, 2)
        painter.setPen(pen)

        # Rounded background
        path = QPainterPath()
        path.addRoundedRect(self.boundingRect(), 10, 10)
        painter.drawPath(path)

        # Conflict flash overlay
        if getattr(self, '_conflict_flash', False):
            painter.setPen(Qt.NoPen)
            painter.setBrush(QBrush(QColor(255, 80, 80, 100)))
            painter.drawPath(path)




        # Set fonts
        name_font = QFont()
        name_font.setPointSize(11)
        name_font.setBold(True)

        # Condensed time font — pull size from settings, default 10pt
        settings = QApplication.instance().settings if hasattr(QApplication.instance(), "settings") else {}
        time_pt = settings.get("time_font_size", 10)
        time_bold = settings.get("time_font_bold", True)

        time_font = QFont("Arial Narrow")
        time_font.setPointSize(time_pt)
        time_font.setBold(time_bold)
        time_font.setLetterSpacing(QFont.AbsoluteSpacing, -0.3)

        task_name = self.name
        start_hour = (self.start_minute // 60) % 24
        start_min = self.start_minute % 60
        end_minute_val = self.start_minute + self.duration
        end_hour = (end_minute_val // 60) % 24
        end_min = end_minute_val % 60

        def fmt_time(hour, minute):
            h12 = hour % 12 or 12
            suffix = "am" if hour < 12 else "pm"
            return f"{h12}:{minute:02}{suffix}"

        time_text = f"{fmt_time(start_hour, start_min)} - {fmt_time(end_hour, end_min)}"

        m_time = QFontMetrics(time_font)
        total_time_width = m_time.width(time_text)

        # Bounding rect and vertical center
        rect = self.boundingRect()
        center_y = rect.y() + rect.height() / 2

        metrics_name = QFontMetrics(name_font)
        name_ascent = metrics_name.ascent()
        time_ascent = m_time.ascent()
        baseline_y = center_y + max(name_ascent, time_ascent) / 2 - 2

        # Draw name (left aligned)
        painter.setFont(name_font)
        painter.setPen(QColor(240, 240, 240))
        painter.drawText(QPointF(rect.x() + 8, baseline_y), task_name)

        # Draw time right-aligned, single font
        CHECKBOX_PADDING = 28
        time_x = rect.right() - total_time_width - CHECKBOX_PADDING
        painter.setFont(time_font)
        painter.setPen(QColor(210, 210, 210))
        painter.drawText(QPointF(time_x, baseline_y), time_text)





        # --- Draw duration pill (pill_dur) ---
        duration = self.get_duration_minutes()
        pill_dur_text = f"{duration}m"

        font = QFont()
        font.setPointSize(8)
        font.setBold(True)
        self.duration_label.setFont(font)
        self.duration_label.setText(pill_dur_text)
        self.duration_label.setBrush(QBrush(QColor(200, 200, 200)))

        metrics = QFontMetrics(font)
        pill_dur_text_width = metrics.width(pill_dur_text)
        pill_dur_text_height = metrics.height()

        pill_dur_width = pill_dur_text_width + 10
        pill_dur_height = 16
        pill_dur_x = self.width - pill_dur_width + 20
        pill_dur_y = -pill_dur_height / 2

        # Drop shadow
        painter.setPen(Qt.NoPen)
        painter.setBrush(QColor(0, 0, 0, 50))
        painter.drawRoundedRect(
            int(pill_dur_x + 1), int(pill_dur_y + 1),
            pill_dur_width, pill_dur_height, 8, 8
        )

        # Pill background with bright reddish-white border
        painter.setBrush(QColor(200, 0, 0, 200))  # Red with opacity
        painter.setPen(QPen(QColor(255, 200, 200), 1))  # Bright reddish-white border
        painter.drawRoundedRect(
            int(pill_dur_x), int(pill_dur_y),
            pill_dur_width, pill_dur_height, 8, 8
        )

        pill_dur_text_x = pill_dur_x + (pill_dur_width - pill_dur_text_width) / 2
        pill_dur_text_y = pill_dur_y + (pill_dur_height - pill_dur_text_height) / 2
        self.duration_label.setPos(pill_dur_text_x, pill_dur_text_y)

        # --- Draw repeat pill (pill_repeat) if recurring ---
        if getattr(self, "recurring", None) == "daily":
            repeat_text = "♻️"
            repeat_font = QFont()
            repeat_font.setPointSize(8)
            metrics_repeat = QFontMetrics(repeat_font)
            repeat_text_width = metrics_repeat.width(repeat_text)
            repeat_text_height = metrics_repeat.height()

            pill_repeat_width = repeat_text_width + 10
            pill_repeat_height = 16
            pill_repeat_x = pill_dur_x - pill_repeat_width - 6
            pill_repeat_y = pill_dur_y

            # Drop shadow
            painter.setPen(Qt.NoPen)
            painter.setBrush(QColor(0, 0, 0, 50))
            painter.drawRoundedRect(
                int(pill_repeat_x + 1), int(pill_repeat_y + 1),
                pill_repeat_width, pill_repeat_height, 8, 8
            )

            # Dark green fill with bright green-white border
            painter.setBrush(QColor(70, 120, 70, 200))  # Darker muted green
            painter.setPen(QPen(QColor(200, 255, 200), 1))  # Greenish-white border
            painter.drawRoundedRect(
                int(pill_repeat_x), int(pill_repeat_y),
                pill_repeat_width, pill_repeat_height, 8, 8
            )

            painter.setPen(QColor(220, 255, 220))  # Light green text
            painter.setFont(repeat_font)
            repeat_text_x = pill_repeat_x + (pill_repeat_width - repeat_text_width) / 2
            repeat_text_y = pill_repeat_y + (pill_repeat_height + repeat_text_height) / 2 - 4
            painter.drawText(QPointF(repeat_text_x, repeat_text_y), repeat_text)

        # --- Resize handle strip at bottom edge (tasks only) ---
        if self.block_type == 'task':
            handle_h = 5
            handle_rect = QRectF(rect.x() + 20, rect.bottom() - handle_h, rect.width() - 40, handle_h)
            if self.isUnderMouse() or self._resizing:
                painter.setBrush(QBrush(QColor(255, 213, 79, 160)))
                painter.setPen(Qt.NoPen)
                painter.drawRoundedRect(handle_rect, 2, 2)



    def update_checkbox_position(self):
        if hasattr(self, 'proxy') and self.proxy:
            cb_width = self.proxy.boundingRect().width()
            cb_height = self.proxy.boundingRect().height()
            x = self.width + 40  # 10px padding from right edge
            y = (self.height - cb_height) / 2  # vertically center
            self.proxy.setPos(x, y)

    def _in_resize_zone(self, pos):
        """Return True if pos (local coords) is in the bottom resize handle strip. Tasks only."""
        if self.block_type != 'task':
            return False
        return (self.boundingRect().bottom() - 8) <= pos.y() <= self.boundingRect().bottom()

    def hoverMoveEvent(self, event):
        if self.block_type == 'task' and self._in_resize_zone(event.pos()):
            self.setCursor(Qt.SizeVerCursor)
        elif self.block_type == 'task':
            self.setCursor(Qt.OpenHandCursor)
        else:
            self.setCursor(Qt.ArrowCursor)
        super().hoverMoveEvent(event)

    def hoverLeaveEvent(self, event):
        self.setCursor(Qt.ArrowCursor)
        super().hoverLeaveEvent(event)

    def mousePressEvent(self, event):
        if event.button() == Qt.LeftButton:
            if self._in_resize_zone(event.pos()):
                self._resizing = True
                self._resize_start_y = event.scenePos().y()
                self._resize_start_duration = self.duration
                event.accept()
                return
            elif self.block_type == 'task':
                # Start a drag-move from anywhere on the block except resize zone
                self._dragging = True
                self._drag_start_scene_y = event.scenePos().y()
                self._drag_start_minute = self.start_minute
                self.setCursor(Qt.ClosedHandCursor)
                event.accept()
                return
        super().mousePressEvent(event)

    def mouseMoveEvent(self, event):
        MIN_DURATION = 15

        if self._resizing:
            delta = int(event.scenePos().y() - self._resize_start_y)
            new_duration = max(MIN_DURATION, self._resize_start_duration + delta)
            new_duration = round(new_duration / 15) * 15
            if new_duration != self.duration:
                self.prepareGeometryChange()
                self.duration = new_duration
                self.height = new_duration
                self.update_checkbox_position()
                self.update()
            event.accept()
            return

        if getattr(self, '_dragging', False):
            delta = int(event.scenePos().y() - self._drag_start_scene_y)
            raw_minute = self._drag_start_minute + delta
            # Snap to 15-min grid
            snapped = round(raw_minute / 15) * 15
            snapped = max(0, min(snapped, 1440 - self.duration))
            if snapped != self.start_minute:
                self.prepareGeometryChange()
                self.start_minute = snapped
                self.setY(snapped)
                self.update_checkbox_position()
                self.update()
            event.accept()
            return

        super().mouseMoveEvent(event)

    def mouseReleaseEvent(self, event):
        if event.button() == Qt.LeftButton:
            if self._resizing:
                self._resizing = False
                self.setCursor(Qt.ArrowCursor)
                self._push_tasks_below(self.start_minute + self.duration)
                self.update_geometry()
                if self.scene() and hasattr(self.scene(), 'parent_app'):
                    self.scene().parent_app.save_all()
                event.accept()
                return

            if getattr(self, '_dragging', False):
                self._dragging = False
                self.setCursor(Qt.ArrowCursor)
                # Push tasks below the dropped position
                self._push_tasks_below(self.start_minute + self.duration)
                self.update_geometry()
                if self.scene() and hasattr(self.scene(), 'parent_app'):
                    self.scene().parent_app.save_all()
                event.accept()
                return

        super().mouseReleaseEvent(event)

    def _push_tasks_below(self, from_minute):
        """Push any tasks that now overlap below 'from_minute' downward. Does not touch tasks above."""
        if not self.scene():
            return
        # Collect all other tasks sorted by start time
        others = sorted(
            [i for i in self.scene().items()
             if isinstance(i, TimeBlock) and i is not self and i.block_type == 'task'],
            key=lambda t: t.start_minute
        )
        cursor = from_minute
        for task in others:
            if task.start_minute < cursor:
                # Only push forward if this task starts inside or before our end
                if task.start_minute + task.duration > self.start_minute:
                    task.start_minute = cursor
                    task.setY(cursor)
                    task.update_geometry()
                    task.flash_conflict()
                    cursor = task.start_minute + task.duration
            elif task.start_minute < cursor:
                task.start_minute = cursor
                task.setY(cursor)
                task.update_geometry()
                task.flash_conflict()
                cursor = task.start_minute + task.duration



    def update_crossed_line(self):
        """Update visual state based on whether the block has crossed the now-line."""
        now = QTime.currentTime()
        now_minute = now.hour() * 60 + now.minute()

        if self.block_type == 'task':
            self.setOpacity(0.4 if self.completed else 1.0)
        elif self.block_type == 'break':
            end_minute = self.start_minute + self.duration
            self.setOpacity(0.4 if end_minute < now_minute else 1.0)




    def update_geometry(self):
        if getattr(self, "_suppress_updates", False):
            return
        # --- Set up colors ---
        settings = QApplication.instance().settings if hasattr(QApplication.instance(), "settings") else {}
        if self.block_type == 'task':
            self.color = QColor(*settings.get("task_color", [60, 100, 200, 180]))
            self.border_color = QColor(*settings.get("task_border_color", [100, 150, 220]))
        else:
            self.color = QColor(*settings.get("break_color", [60, 120, 80, 180]))
            self.border_color = QColor(*settings.get("break_border_color", [100, 200, 120]))

        duration = self.get_duration_minutes()

        # --- Wrap across timeline if needed ---
        if hasattr(self.scene(), "parent_app") and hasattr(self.scene().parent_app, "ensure_inside_timeline"):
            app = self.scene().parent_app
            self.start_minute = app.ensure_inside_timeline(self.start_minute, self.duration)

        # --- Break overlap jump for tasks ---
        if self.block_type == 'task' and self.scene():
            for item in self.scene().items():
                if item != self and hasattr(item, 'block_type') and item.block_type == 'break':
                    task_start = self.start_minute
                    task_end = task_start + self.duration
                    break_start = item.start_minute
                    break_end = break_start + item.duration

                    if task_start < break_end and task_end > break_start:
                        new_start, new_end = self.scene().parent_app.find_next_free_slot(
                            duration, start_from=self.start_minute
                        )
                        if new_start is not None and new_end is not None:
                            self.start_minute = new_start
                            self.duration = new_end - new_start
                        break  # Only jump once

        # --- Compute updated position and size ---
        top = self.start_minute
        self.height = max(duration, 15)
        self.setX(10)

        # --- Place block unless already in void ---
        if 0 <= self.y() <= 1440:
            print(f"⏬ Normal placement at {top}")
            self.setY(top)
        else:
            print(f"☁️  Void-preserved Y at {self.y()} (start_minute = {self.start_minute})")

        # --- Checkbox positioning ---
        if self.block_type == 'task':
            self.update_checkbox_position()

        # --- Fade for completed tasks ---
        self.update_crossed_line()


        #self.setOpacity(0.4 if self.completed else 1.0)  -- OLD
        #now = QTime.currentTime()
        #now_minute = now.hour() * 60 + now.minute()

        #if self.block_type == 'task':
        #    self.setOpacity(0.4 if self.completed else 1.0)
        #elif self.block_type == 'break':
        #    end_minute = self.start_minute + self.duration
        #    self.setOpacity(0.4 if end_minute < now_minute else 1.0)


        # --- Duration pill ---
        self.duration_label.setText(f"{duration}m")
        pill_width = self.duration_label.boundingRect().width() + 12
        pill_height = 16
        x = self.width - pill_width / 2
        y = -pill_height / 2
        self.duration_label.setPos(x + 4, y)





    def handle_task_swap(self, other, direction):
        parent = self.scene().parent()

        my_dur = self.get_duration_minutes()
        other_dur = other.get_duration_minutes()

        if direction < 0:
            # Moving UP: self takes other's spot, other goes below
            self.start_minute = other.start_minute
            self.duration = my_dur
            self.setY(parent.time_to_y(self.start_minute))
            self.update_geometry()

            other.start_minute = self.start_minute + my_dur
            other.duration = other_dur
            other.setY(parent.time_to_y(other.start_minute))
            other.update_geometry()
        else:
            # Moving DOWN: other moves up, self takes its place
            other.start_minute = self.start_minute
            other.duration = other_dur
            other.setY(parent.time_to_y(other.start_minute))
            other.update_geometry()

            self.start_minute = other.start_minute + other_dur
            self.duration = my_dur
            self.setY(parent.time_to_y(self.start_minute))
            self.update_geometry()





    def move_task(self, delta_minutes):
        print(f"Task '{self.name}' was told to move")
        if self.block_type != 'task':
            return

        scene = self.scene()
        parent = scene.parent()
        duration = self.get_duration_minutes()
        direction = 1 if delta_minutes > 0 else -1

        def from_minutes(m): return QTime((m % 1440) // 60, m % 60)

        new_start_min = self.start_minute + delta_minutes
        new_end_min = new_start_min + self.duration

        # 🧹 Clean wraparound: if it lands even partially beyond bounds, fully reset to other side
        if new_end_min > 1440:
            print("🕛 Task crossed 12:00 AM — wrap to top")
            new_start_min = 0
            new_end_min = new_start_min + self.duration

        elif new_start_min < 0:
            print("🌅 Task went above 00:00 — wrap to bottom")
            new_end_min = 1440
            new_start_min = new_end_min - self.duration

        # Convert to QTime equivalents
        new_start = from_minutes(new_start_min)
        new_end = from_minutes(new_end_min)

        visited_positions = set()
        # ... continue with your existing break jump and conflict logic

        # --- Step 1: Break jump (preserved) ---
        while True:
            jumped = False
            task_start_min = new_start_min
            task_end_min = new_end_min

            for item in scene.items():
                if not hasattr(item, 'block_type') or item.block_type != 'break':
                    continue

                break_start = item.start_minute
                break_end = item.start_minute + item.duration
                if break_end <= break_start:
                    break_end += 1440

                if not (task_end_min <= break_start or task_start_min >= break_end):
                    tentative_start_min = (
                        break_end if direction > 0 else break_start - duration
                    )
                    tentative_end_min = tentative_start_min + duration

                    pos_key = (tentative_start_min, direction)
                    if pos_key in visited_positions:
                        print("🔁 Loop detected during break jump")
                        return
                    visited_positions.add(pos_key)

                    tentative_start = from_minutes(tentative_start_min)
                    tentative_end = from_minutes(tentative_end_min)

                    # Check task-task collision
                    conflict = False
                    for other in scene.items():
                        if other == self or not hasattr(other, 'block_type') or other.block_type != 'task':
                            continue
                        if tentative_start_min < other.start_minute + other.duration and tentative_end_min > other.start_minute:
                            conflict = True
                            break

                    if conflict:
                        print("⛔ Blocked by task after break jump")
                        return

                    # Accept jump
                    new_start = tentative_start
                    new_end = tentative_end
                    new_start_min = tentative_start_min
                    new_end_min = tentative_end_min
                    jumped = True
                    break

            if not jumped:
                break

        # --- Step 2: Wraparound ---
        if new_start_min >= 1440:
            print("🔄 Wrapping to top (00:00)")
            new_start_min = 0
            new_end_min = new_start_min + duration

        elif new_end_min <= 0:
            print("🔄 Wrapping to bottom (~23:59)")
            new_end_min = 1439
            new_start_min = new_end_min - duration



        # --- Step 3: Task-task swap ---
        for item in scene.items():
            if item == self or not hasattr(item, 'block_type') or item.block_type != 'task':
                continue

            other_start_min = item.start_minute
            other_end_min = item.start_minute + item.duration
            if other_end_min <= other_start_min:
                other_end_min += 1440

            if not (new_end_min <= other_start_min or new_start_min >= other_end_min):
                self.handle_task_swap(item, direction)
                return

        # --- Step 4: Final apply ---
        self.start_minute = new_start_min
        self.setY(parent.time_to_y(self.start_minute))
        self.update_geometry()




    def mouseDoubleClickEvent(self, event):
        duration = self.get_duration_minutes()

        dialog = TimeSlotDialog(
            current_duration=duration,
            name=self.name,
            block_type=self.block_type,
            recurring=self.recurring
        )

        # Center dialog on the main app window
        if self.scene() and hasattr(self.scene(), 'parent_app'):
            app_win = self.scene().parent_app
            dialog.move(
                app_win.geometry().center() - dialog.rect().center()
            )

        # Set dialog start time from self.start_minute
        start_hour = (self.start_minute // 60) % 24
        start_min = self.start_minute % 60
        dialog.start_time.setTime(QTime(start_hour, start_min))

        if dialog.exec_() == QDialog.Accepted:
            self.name = dialog.name_input.toPlainText().strip() or 'Untitled'
            new_type = "task" if dialog.task_radio.isChecked() else "break"

            if new_type != self.block_type:
                self.update_type(new_type)

            self.recurring = "daily" if dialog.repeat_daily_radio.isChecked() else "none"

            # Set updated start and duration
            qtime = dialog.start_time.time()
            raw_start = qtime.hour() * 60 + qtime.minute()
            self.duration = dialog.duration_input.currentData()

            # ✅ Wrap within timeline
            self.start_minute = self.scene().parent_app.ensure_inside_timeline(raw_start, self.duration)

            self.update_geometry()

            # ✅ Trigger resolve_conflicts for BOTH tasks and breaks
            if self.scene() and hasattr(self.scene().parent_app, "resolve_conflicts"):
                self.scene().parent_app.resolve_conflicts(self)

            self.scene().parent_app.save_all()






    def to_dict(self):
        return {
            'start': self.format_time(self.start_minute),
            'end': self.format_time(self.start_minute + self.duration),
            'type': self.block_type,
            'name': self.name,
            'completed': self.completed
        }



def minutes_to_str(minute):
    return f"{minute // 60:02}:{minute % 60:02}"

class SchedulerApp(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Day Planner v1.0")
        self.setFixedSize(480, 740)
        self.current_data_file = DATA_FILE_PATH

        layout = QVBoxLayout(self)
        self.scene = QGraphicsScene(0, -20, 480, 1440 + 30)  # or even 1540 for 1-hour buffer
        self.scene.setBackgroundBrush(QBrush(QColor(17, 17, 17)))  # same as #111 used earlier
        self.scene.parent_app = self  # ✅ Add this line
        self.view = QGraphicsView(self.scene)
        self.view.setStyleSheet("""
            QGraphicsView {
                border-radius: 10px;
                border: 1px solid #333;
            }
        """)
        self.view.setRenderHints(QPainter.Antialiasing | QPainter.SmoothPixmapTransform)
        # Shift everything visually down by 10 pixels
        #self.view.setTransform(QTransform().translate(0, 50))

        self.view.setFixedWidth(440)
        self.view.setRenderHints(QPainter.Antialiasing)
        self.view.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.view.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.view.setAlignment(Qt.AlignTop | Qt.AlignLeft)
        self.view.setScene(self.scene)
        self.scene.parent = lambda: self

        self.last_deleted = None
        self.shortcut_undo = QShortcut(QKeySequence("Ctrl+Z"), self)
        self.shortcut_undo.activated.connect(self.undo_delete)


        layout.addWidget(self.view)
        self.draw_timeline()

        btn_layout = QHBoxLayout()
        btn_layout.setSpacing(8)

        self.add_btn = self.make_button("Add", "#7AA9D9")        # Muted Blue
        self.del_btn = self.make_button("Delete", "#D78C8C")     # Muted Red
        self.clear_btn = self.make_button("Clear All", "#BD92C2")# Muted Purple
        self.auto_btn = self.make_button("Auto Plan", "#E8B977") # Muted Orange
        self.settings_btn = self.make_button("Set", "#A0A6AD")   # Muted Grey-Blue

        self.add_btn.clicked.connect(self.add_block)
        self.del_btn.clicked.connect(self.delete_selected)
        self.clear_btn.clicked.connect(self.clear_all)
        self.auto_btn.clicked.connect(self.auto_plan_tasks)
        self.settings_btn.clicked.connect(self.open_settings_dialog)





        for btn in (self.add_btn, self.del_btn, self.clear_btn, self.auto_btn, self.settings_btn):
            btn_layout.addWidget(btn)
        layout.addLayout(btn_layout)

        # Initialize default settings if not already loaded
        self.settings = {
            "task_color": [60, 100, 200, 180],
            "task_border_color": [100, 150, 220],
            "break_color": [60, 120, 80, 180],
            "break_border_color": [100, 200, 120]
        }

        self.load_all()

        self.now_line = None  # Let update_now_line() handle creation
        self.now_label = None
        self.now_label_bg = None
        self.update_now_line()

        # --- Daily summary bar ---
        self.summary_label = QLabel("")
        self.summary_label.setAlignment(Qt.AlignCenter)
        self.summary_label.setStyleSheet(
            "color: #444; font-size: 11px; font-weight: 500; padding: 2px 0;"
        )
        layout.addWidget(self.summary_label)
        self.update_summary_bar()

        timer = QTimer(self)
        timer.timeout.connect(self.update_now_line)
        timer.start(60000)
        self.center_on_now()



    def animate_task_movement(self, task, new_y):
        start_y = task.y()
        end_y = new_y

        if abs(start_y - end_y) < 1:
            return  # Skip if no actual movement

        anim = QVariantAnimation()
        anim.setDuration(300)
        anim.setStartValue(start_y)
        anim.setEndValue(end_y)
        anim.setEasingCurve(QEasingCurve.OutCubic)  # Smooth deceleration

        anim.valueChanged.connect(lambda y: task.setY(y))

        def on_finished():
            task.setY(end_y)
            task.start_minute = int(end_y)
            task.update_geometry()

        anim.finished.connect(on_finished)

        task.anim = anim  # Prevent garbage collection
        anim.start()



    def safe_remove_item(self, item):
        if item and item.scene() == self.scene:
            self.scene.removeItem(item)
        if hasattr(item, 'proxy') and item.proxy and item.proxy.scene() == self.scene:
            self.scene.removeItem(item.proxy)




    def ensure_inside_timeline(self, start_minute, duration):
        end_minute = start_minute + duration

        if end_minute > 1440:
            # Crossed midnight downward — wrap to top
            start_minute = (start_minute + duration) % 1440
        elif start_minute < 0:
            # Crossed 00:00 upward — wrap to bottom
            start_minute = (start_minute + 1440) % 1440

        return start_minute
    


    def apply_color_scheme(self, scheme_name):
        scheme = COLOR_SCHEMES.get(scheme_name)
        if not scheme:
            return

        self.settings.update(scheme)
        QApplication.instance().settings = self.settings

        # Background based on theme name
        if scheme_name == "Default":
            self.set_background_color(QColor(50, 50, 50))  # light gray
        elif scheme_name == "Gray":
            self.set_background_color(QColor(20, 20, 20))  # dark gray

        # Redraw all blocks
        for item in self.scene.items():
            if hasattr(item, "update_geometry"):
                item.update_geometry()




    def set_background_color(self, color: QColor):
        self.scene.setBackgroundBrush(QBrush(color))



    def undo_delete(self):
        if not self.last_deleted:
            return

        if isinstance(self.last_deleted, list):
            for block in self.last_deleted:
                self.scene.addItem(block)
                if hasattr(block, 'proxy') and block.proxy:
                    self.scene.addItem(block.proxy)
                block.update_geometry()
        else:
            block = self.last_deleted
            self.scene.addItem(block)
            if hasattr(block, 'proxy') and block.proxy:
                self.scene.addItem(block.proxy)
            block.update_geometry()

        self.last_deleted = None
        self.save_all()





    def center_on_now(self):
        now = QTime.currentTime()
        minute = now.hour() * 60 + now.minute()
        y = self.time_to_y(minute)
        self.view.centerOn(0, y + 100)


    def update_summary_bar(self):
        """Recompute and display the daily time accounting summary."""
        if not hasattr(self, 'summary_label'):
            return

        day_start = self.settings.get("day_start_minute", 540)
        day_end   = self.settings.get("day_end_minute",   1080)
        total_day = max(day_end - day_start, 1)

        tasks  = [i for i in self.scene.items() if isinstance(i, TimeBlock) and i.block_type == 'task']
        breaks = [i for i in self.scene.items() if isinstance(i, TimeBlock) and i.block_type == 'break']

        planned_min   = sum(t.duration for t in tasks)
        completed_min = sum(t.duration for t in tasks if t.completed)
        break_min     = sum(b.duration for b in breaks)
        free_min      = max(total_day - planned_min - break_min, 0)

        def fmt(m):
            h, mn = divmod(m, 60)
            if h and mn:
                return f"{h}h {mn}m"
            elif h:
                return f"{h}h"
            return f"{mn}m"

        self.summary_label.setText(
            f"Done: {fmt(completed_min)}  ·  Free: {fmt(free_min)}"
        )


    def make_button(self, label, color):
        btn = QPushButton(label)
        btn.setStyleSheet(f"""
            QPushButton {{
                background-color: {color};
                color: black;
                border-radius: 6px;
                padding: 6px 12px;
                font-weight: bold;
            }}
            QPushButton:hover {{
                border: 2px solid #FFD54F;
            }}
        """)
        btn.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Preferred)
        return btn



    def update_now_line__old(self):
        now = QTime.currentTime()
        minute = now.hour() * 60 + now.minute()
        y = self.time_to_y(minute)
        self.now_line.setLine(0, y, 480, y)

        # Format time in hh:mm AM/PM
        time_text = now.toString("hh:mm AP")

        # Remove existing pill background safely
        if hasattr(self, 'now_label_bg') and self.now_label_bg:
            self.safe_remove_item(self.now_label_bg)
            self.now_label_bg = None


        # Compute pill dimensions and position
        pill_now_width = 60
        pill_now_height = 18
        pill_now_x = 0
        pill_now_y = y - pill_now_height / 2

        rect = QRectF(pill_now_x, pill_now_y, pill_now_width, pill_now_height)
        path = QPainterPath()
        path.addRoundedRect(rect, 9, 9)

        pill_fill = QColor(200, 0, 0, 200)
        pill_border = QPen(QColor(255, 200, 200))
        pill_border.setWidth(1)

        self.now_label_bg = self.scene.addPath(path, pill_border, QBrush(pill_fill))
        self.now_label_bg.setZValue(8)

        # Remove and recreate now_label safely if needed
        if hasattr(self, 'now_label') and self.now_label:
            if self.now_label.scene() != self.scene:
                self.now_label = None  # already orphaned, just reset

        if not hasattr(self, 'now_label') or self.now_label is None:
            self.now_label = QGraphicsTextItem()
            self.scene.addItem(self.now_label)

        # Set text
        self.now_label.setPlainText(time_text)
        font = QFont("Arial", 9)
        font.setBold(True)
        self.now_label.setFont(font)
        self.now_label.setDefaultTextColor(QColor(200, 200, 200))

        # Align text inside the pill
        metrics = QFontMetrics(font)
        text_rect = metrics.boundingRect(time_text)

        text_x = pill_now_x + (pill_now_width - text_rect.width()) / 2 - 4
        text_y = pill_now_y + (pill_now_height - text_rect.height()) / 2 - 4

        self.now_label.setPos(text_x, text_y)
        self.now_label.setZValue(10)



        # Compute pill dimensions and position
        pill_now_width = 60
        pill_now_height = 18
        pill_now_x = 0
        pill_now_y = y - pill_now_height / 2  # vertically center around line

        # Rounded rectangle path
        rect = QRectF(pill_now_x, pill_now_y, pill_now_width, pill_now_height)
        path = QPainterPath()
        path.addRoundedRect(rect, 9, 9)

        # Colors (match duration pill)
        pill_fill = QColor(200, 0, 0, 200)               # Same red fill
        pill_border = QPen(QColor(255, 200, 200))        # Bright reddish-white border
        pill_border.setWidth(1)

        # Remove old and draw new
        if hasattr(self, 'now_label_bg'):
            self.scene.removeItem(self.now_label_bg)

        self.now_label_bg = self.scene.addPath(path, pill_border, QBrush(pill_fill))
        self.now_label_bg.setZValue(8)

        # Create or update label
        if not hasattr(self, 'now_label'):
            self.now_label = QGraphicsTextItem()
            self.scene.addItem(self.now_label)

        # Set text
        time_text = now.toString("hh:mm AP")
        self.now_label.setPlainText(time_text)
        font = QFont("Arial", 9)
        font.setBold(True)
        self.now_label.setFont(font)
        self.now_label.setDefaultTextColor(QColor(200, 200, 200))

        # Align text inside the pill (using ascent for vertical centering)
        metrics = QFontMetrics(font)
        text_rect = metrics.boundingRect(time_text)

        text_x = pill_now_x + (pill_now_width - text_rect.width()) / 2 - 4
        text_y = pill_now_y + (pill_now_height - text_rect.height()) / 2 - 4

        self.now_label.setPos(text_x, text_y)
        self.now_label.setZValue(10)


        # Update break/task opacity
        for item in self.scene.items():
            if isinstance(item, TimeBlock):
                item.update_crossed_line()


    def update_now_line__old3(self):
        now = QTime.currentTime()
        minute = now.hour() * 60 + now.minute()
        y = self.time_to_y(minute)
        self.now_line.setLine(0, y, 480, y)

        # --- Build time label string ---
        time_text = now.toString("hh:mm AP")

        # --- Dimensions & style ---
        pill_now_width = 60
        pill_now_height = 18
        pill_now_x = 0
        pill_now_y = y - pill_now_height / 2
        font = QFont("Arial", 9)
        font.setBold(True)
        text_color = QColor(200, 200, 200)
        pill_fill = QColor(200, 0, 0, 200)
        pill_border = QPen(QColor(255, 200, 200))
        pill_border.setWidth(1)

        # --- Remove previous pill shape safely ---
        if hasattr(self, 'now_label_bg') and self.now_label_bg:
            self.safe_remove_item(self.now_label_bg)

        # --- Create pill shape ---
        rect = QRectF(pill_now_x, pill_now_y, pill_now_width, pill_now_height)
        path = QPainterPath()
        path.addRoundedRect(rect, 9, 9)
        self.now_label_bg = self.scene.addPath(path, pill_border, QBrush(pill_fill))
        self.now_label_bg.setZValue(8)

        # --- Create or reuse label ---
        if not hasattr(self, 'now_label') or self.now_label is None or self.now_label.scene() != self.scene:
            self.now_label = QGraphicsTextItem()
            self.scene.addItem(self.now_label)

        self.now_label.setPlainText(time_text)
        self.now_label.setFont(font)
        self.now_label.setDefaultTextColor(text_color)

        # --- Center text inside pill ---
        metrics = QFontMetrics(font)
        text_rect = metrics.boundingRect(time_text)
        text_x = pill_now_x + (pill_now_width - text_rect.width()) / 2 - 4
        text_y = pill_now_y + (pill_now_height - text_rect.height()) / 2 - 4
        self.now_label.setPos(text_x, text_y)
        self.now_label.setZValue(10)

        # --- Update opacity for breaks/tasks ---
        for item in self.scene.items():
            if isinstance(item, TimeBlock):
                item.update_crossed_line()



    def update_now_line(self):
        now = QTime.currentTime()
        minute = now.hour() * 60 + now.minute()
        y = self.time_to_y(minute)

        # --- Create line if not yet created ---
        if not self.now_line:
            pen = QPen(QColor(255, 0, 0, 127), 3)
            self.now_line = self.scene.addLine(0, y, 480, y, pen)
            self.now_line.setZValue(9.5)
        else:
            self.now_line.setLine(0, y, 480, y)

        # --- Build time label string ---
        time_text = now.toString("hh:mm AP")

        # --- Dimensions & style ---
        pill_now_width = 60
        pill_now_height = 18
        pill_now_x = 0
        pill_now_y = y - pill_now_height / 2
        font = QFont("Arial", 9)
        font.setBold(True)
        text_color = QColor(200, 200, 200)
        pill_fill = QColor(200, 0, 0, 200)
        pill_border = QPen(QColor(255, 200, 200))
        pill_border.setWidth(1)

        # --- Remove previous pill background safely ---
        if self.now_label_bg:
            self.safe_remove_item(self.now_label_bg)
            self.now_label_bg = None

        # --- Create pill shape ---
        rect = QRectF(pill_now_x, pill_now_y, pill_now_width, pill_now_height)
        path = QPainterPath()
        path.addRoundedRect(rect, 9, 9)
        self.now_label_bg = self.scene.addPath(path, pill_border, QBrush(pill_fill))
        self.now_label_bg.setZValue(8)

        # --- Create label if needed ---
        if not self.now_label or self.now_label.scene() != self.scene:
            self.now_label = QGraphicsTextItem()
            self.scene.addItem(self.now_label)

        self.now_label.setPlainText(time_text)
        self.now_label.setFont(font)
        self.now_label.setDefaultTextColor(text_color)

        # --- Center label in pill ---
        metrics = QFontMetrics(font)
        text_rect = metrics.boundingRect(time_text)
        text_x = pill_now_x + (pill_now_width - text_rect.width()) / 2 - 4
        text_y = pill_now_y + (pill_now_height - text_rect.height()) / 2 - 4
        self.now_label.setPos(text_x, text_y)
        self.now_label.setZValue(10)

        # --- Update task/break opacity ---
        for item in self.scene.items():
            if isinstance(item, TimeBlock):
                item.update_crossed_line()



    def draw_timeline(self):
        for hour in range(25):  # 0 to 24 inclusive = 25 hours
            y = hour * 60

            label = f"{(hour % 12 or 12):02d}:00{'am' if hour < 12 or hour == 24 else 'pm'}"
            text = QGraphicsTextItem(label)
            text.setDefaultTextColor(Qt.darkGray)
            text_height = text.boundingRect().height()
            text.setPos(2, y - text_height / 2)
            self.scene.addItem(text)

            # Hour line
            hour_pen = QPen(QColor(200, 200, 200, 50))
            hour_pen.setWidthF(2)
            self.scene.addLine(64, y, 470, y, hour_pen)

            # Half-hour line (skip after 24:00 / 1:00am)
            if hour < 24:
                y_half = y + 30
                half_pen = QPen(QColor(200, 200, 200, 40))
                half_pen.setWidthF(0.5)
                self.scene.addLine(10, y_half, 470, y_half, half_pen)




    def add_block(self):
        dialog = TimeSlotDialog(self)

        # ✅ Center the dialog relative to the main app window
        #parent_center = self.frameGeometry().center()
        #dialog_geom = dialog.frameGeometry()
        #dialog_geom.moveCenter(parent_center)
        #dialog.move(dialog_geom.topLeft())

        dialog.move(
            self.geometry().center() - dialog.rect().center() / 2
        )


        if dialog.exec_() == QDialog.Accepted:
            names = [line.strip() for line in dialog.name_input.toPlainText().splitlines() if line.strip()]
            btype = dialog.selected_type()
            duration = dialog.duration_input.currentData()
            recurring = dialog.selected_repeat()

            if not names:
                return

            if btype == 'break':
                # 🚫 Only allow a single break block
                name = names[0]
                start_qtime = dialog.start_time.time()
                start_minute = start_qtime.hour() * 60 + start_qtime.minute()
                block = TimeBlock(start_minute, duration, btype, name, recurring=recurring)
                self.scene.addItem(block)

            else:
                # ✅ Add each task one after another
                for name in names:
                    start_minute, end_minute = self.find_next_free_slot(duration)
                    block = TimeBlock(start_minute, duration, btype, name, recurring=recurring)
                    self.scene.addItem(block)

            self.save_all()




    def find_next_free_slot(self, duration_min, start_from=None, direction=1):
        # Step 1: Determine current start point
        if start_from is not None:
            current_minute = start_from
        else:
            now = QTime.currentTime()
            aligned_min = ((now.minute() + 14) // 15) * 15
            current_minute = now.hour() * 60 + aligned_min

        # Step 2: Clamp inside timeline (defensive coding)
        current_minute = max(0, min(current_minute, 1440 - duration_min))

        # Step 3: Align to 15-minute grid
        if current_minute % 15 != 0:
            current_minute += 15 - (current_minute % 15)

        # Step 4: Build occupied slots (tasks + breaks)
        occupied = sorted([
            (item.start_minute, item.start_minute + item.duration)
            for item in self.scene.items()
            if hasattr(item, 'block_type')
        ])

        # Step 5: Loop until a free slot is found or bounds exceeded
        while 0 <= current_minute <= 1440 - duration_min:
            start_minute = current_minute
            end_minute = start_minute + duration_min

            conflict = any(
                not (end_minute <= occ_start or start_minute >= occ_end)
                for occ_start, occ_end in occupied
            )

            if not conflict:
                return start_minute, end_minute

            # Step 6: Move to next slot
            current_minute += 15 * direction

        # Step 7: Fallback if no slot found
        return None, None



    def resolve_conflicts(self, moved_block):
        moved_end = moved_block.start_minute + moved_block.duration

        # Only look at blocks starting at or after moved_block
        forward_blocks = sorted(
            [item for item in self.scene.items()
            if isinstance(item, TimeBlock)
            and item != moved_block
            and item.start_minute >= moved_block.start_minute],
            key=lambda x: x.start_minute
        )

        for block in forward_blocks:
            if block.start_minute < moved_end:
                if block.block_type == 'task':
                    duration = block.duration
                    block.start_minute = moved_end
                    block.setY(moved_end)
                    block.update_geometry()
                    block.flash_conflict()
                    moved_end += duration
            else:
                break



    def open_settings_dialog(self):
        dlg = QDialog(self)
        dlg.setWindowTitle("Customize Colors")
        layout = QFormLayout()

        # Theme dropdown
        theme_dropdown = QComboBox()
        theme_dropdown.addItems(COLOR_SCHEMES.keys())

        # Set current theme from settings
        current_theme = self.settings.get("theme", "Default")
        if current_theme in COLOR_SCHEMES:
            theme_dropdown.setCurrentText(current_theme)
        else:
            theme_dropdown.setCurrentIndex(0)  # fallback

        layout.addRow("Color Theme:", theme_dropdown)

        # --- Day start / end time for daily summary ---
        day_start_edit = QTimeEdit()
        day_start_edit.setDisplayFormat("hh:mm AP")
        day_end_edit = QTimeEdit()
        day_end_edit.setDisplayFormat("hh:mm AP")

        saved_start = self.settings.get("day_start_minute", 540)   # default 9:00 AM
        saved_end   = self.settings.get("day_end_minute",   1080)  # default 6:00 PM
        day_start_edit.setTime(QTime(saved_start // 60, saved_start % 60))
        day_end_edit.setTime(QTime(saved_end   // 60, saved_end   % 60))

        layout.addRow("Day starts:", day_start_edit)
        layout.addRow("Day ends:",   day_end_edit)

        # --- Time range font size + bold ---
        time_size_spin = QSpinBox()
        time_size_spin.setRange(7, 16)
        time_size_spin.setValue(self.settings.get("time_font_size", 10))

        time_bold_check = QCheckBox("Bold")
        time_bold_check.setChecked(self.settings.get("time_font_bold", True))

        time_font_row = QHBoxLayout()
        time_font_row.addWidget(time_size_spin)
        time_font_row.addWidget(time_bold_check)

        layout.addRow("Time font size:", time_size_spin)
        layout.addRow("Time font bold:", time_bold_check)

        # Display full path of the loaded JSON file
        file_label = QLabel("Loaded File:")
        file_value = QLabel(self.current_data_file)
        file_value.setWordWrap(True)
        file_value.setStyleSheet("color: gray; font-style: italic;")
        layout.addRow(file_label, file_value)


        # Manual color overrides
        color_keys = [
            "task_color", "task_border_color",
            "break_color", "break_border_color"
        ]

        def pick_color(key, label):
            current = QColor(*self.settings.get(key, [0, 0, 0, 255]))
            new_color = QColorDialog.getColor(current, dlg)
            if new_color.isValid():
                rgba = [new_color.red(), new_color.green(), new_color.blue(), new_color.alpha()]
                self.settings[key] = rgba
                label.setText(f"{key}: {rgba}")

        for key in color_keys:
            label = QLabel(f"{key}: {self.settings.get(key)}")
            btn = QPushButton("Change")
            btn.clicked.connect(lambda _, k=key, l=label: pick_color(k, l))
            layout.addRow(label, btn)

        # Save and apply
        def apply_changes():
            selected_theme = theme_dropdown.currentText()

            # Save day start/end times
            ds = day_start_edit.time()
            de = day_end_edit.time()
            self.settings["day_start_minute"] = ds.hour() * 60 + ds.minute()
            self.settings["day_end_minute"]   = de.hour() * 60 + de.minute()

            # Save time font settings
            self.settings["time_font_size"] = time_size_spin.value()
            self.settings["time_font_bold"] = time_bold_check.isChecked()

            # If a theme is selected from dropdown, apply it
            if selected_theme in COLOR_SCHEMES:
                self.apply_color_scheme(selected_theme)
                self.settings["theme"] = selected_theme  # ✅ Save theme name in settings

            # Update each block with new settings
            QApplication.instance().settings = self.settings
            for item in self.scene.items():
                if hasattr(item, "update_geometry"):
                    item.update_geometry()
                elif isinstance(item, TimeBlock):
                    item.update()

            # Save and close
            self.save_all()
            self.update_summary_bar()
            dlg.accept()

        save_btn = QPushButton("Save and Close")
        save_btn.clicked.connect(apply_changes)
        layout.addRow(save_btn)

        dlg.setLayout(layout)

        dlg.setParent(self, Qt.Dialog)
        dlg.setWindowModality(Qt.ApplicationModal)
        dlg.move(
            self.geometry().center() - dlg.rect().center()
        )

        dlg.exec_()





    def time_to_y(self, minute):
        """Convert integer minute to vertical Y position."""
        return minute  # 1 minute = 1 pixel

    def y_to_time(self, y):
        """Convert vertical Y position back to integer minutes."""
        return int(y)  # 1 pixel = 1 minute


    def overlaps_break(self, y, height):
        for item in self.scene.items():
            if hasattr(item, 'block_type') and item.block_type == 'break':
                iy = item.y()
                ih = item.height
                if (y < iy + ih and y + height > iy):
                    return True
        return False




    def auto_plan_tasks(self):
        now = QTime.currentTime()
        now_minute = now.hour() * 60 + now.minute()
        now_minute = (now_minute + 14) // 15 * 15  # Align to 15-min grid

        all_blocks = [item for item in self.scene.items() if hasattr(item, 'block_type')]
        tasks = [b for b in all_blocks if b.block_type == 'task']

        completed_below = []
        completed_above = []
        uncompleted = []

        for task in tasks:
            if task.completed:
                if task.start_minute + task.duration < now_minute:
                    completed_above.append(task)
                else:
                    completed_below.append(task)
            else:
                uncompleted.append(task)

        # --- Move completed tasks below current time upward ---
        past_minute = now_minute - 5
        for task in sorted(completed_below, key=lambda t: t.start_minute, reverse=True):
            duration = task.duration
            new_start = past_minute - duration

            if new_start < 0:
                task.safe_remove_item()  # Off timeline
                continue

            task.start_minute = self.ensure_inside_timeline(new_start, duration)
            task.setY(task.start_minute)
            task.update_geometry()
            past_minute = task.start_minute - 1

        # --- Remove uncompleted tasks temporarily ---
        for task in uncompleted:
            self.safe_remove_item(task)

        # --- Re-insert uncompleted tasks ---
        future_minute = now_minute + 5
        wrapped = False

        # Helper: builds current occupied list from scene
        def get_occupied():
            return sorted([
                (item.start_minute, item.start_minute + item.duration)
                for item in self.scene.items()
                if hasattr(item, 'block_type')
            ])

        # --- Re-insert uncompleted tasks from current time ---
        future_minute = now_minute + 5
        wrapped = False

        for task in uncompleted:
        #for task in sorted(uncompleted, key=lambda t: t.name):  # stable order
            duration = task.duration
            retry = 0

            # Temporarily suppress geometry update
            task._suppress_updates = True

            # Look for valid position
            while self.task_conflict(future_minute, duration) or self.overlaps_break(future_minute, duration):
                future_minute += 1
                retry += 1

                if future_minute + duration >= 1440 and not wrapped:
                    future_minute = 0
                    wrapped = True
                    retry = 0

                if retry > 2000:
                    print(f"⚠️ Could not place task: {task.name}")
                    break

            valid_start = self.ensure_inside_timeline(future_minute, duration)
            task.start_minute = valid_start
            task.setY(valid_start)

            self.scene.addItem(task)

            # Allow geometry update only after placement
            task._suppress_updates = False
            task.update_geometry()

            future_minute = valid_start + duration + 1

        self.save_all()












    def task_conflict(self, y, height):
        for item in self.scene.items():
            if hasattr(item, 'block_type') and item.block_type != 'break':
                iy = item.y()
                ih = item.height
                if (y < iy + ih and y + height > iy):
                    return True
        return False







    def move_task(self, delta_minutes):
        print(f"→ Moving selected task by {delta_minutes} minutes")
        for item in self.scene.items():
            if isinstance(item, TimeBlock) and item.isSelected():
                item.move_task(delta_minutes)
                break



    def delete_selected(self):
        for item in self.scene.selectedItems():
            if hasattr(item, "safe_remove_item"):
                item.safe_remove_item()
        self.save_all()



    def clear_all(self):
        reply = QMessageBox.question(
            self, "Confirm Clear All",
            "Are you sure you want to delete all blocks?",
            QMessageBox.Yes | QMessageBox.No
        )
        if reply != QMessageBox.Yes:
            return

        for item in list(self.scene.items()):
            if isinstance(item, TimeBlock):
                item.safe_remove_item()

        self.save_all()





    def save_all(self):
        blocks = []
        for item in self.scene.items():
            if isinstance(item, TimeBlock):
                blocks.append({
                    "name": item.name,
                    "start_minute": item.start_minute,
                    "duration": item.duration,
                    "completed": item.completed,
                    "type": item.block_type,
                    "tag_color": [item.tag_color.red(), item.tag_color.green(), item.tag_color.blue(), item.tag_color.alpha()] if item.tag_color else None,
                    "recurring": getattr(item, "recurring", "none"),
                    "theme": self.settings.get("theme", "Default"),
                })

        data = {
            "settings": self.settings,
            "blocks": blocks
        }

        with open(self.current_data_file, "w") as f:
            json.dump(data, f, indent=2)

        self.update_summary_bar()






    def load_all(self, filepath="data.json"):
        #self.current_data_file = filepath
        self.settings = {
            "task_color": [60, 100, 200, 180],
            "task_border_color": [100, 150, 220],
            "break_color": [60, 120, 80, 180],
            "break_border_color": [100, 200, 120]
        }

        try:
            with open(self.current_data_file, "r") as f:
                data = json.load(f)
                self.settings.update(data.get("settings", {}))
                theme = self.settings.get("theme", "Default")
                if theme in COLOR_SCHEMES:
                    self.apply_color_scheme(theme)

                loaded_keys = set()

                # --- Main load loop ---
                for b in data.get("blocks", []):
                    start_minute = b.get("start_minute", 0)
                    duration = b.get("duration", 60)
                    name = b.get("name", "Untitled")
                    recurring = b.get("recurring", "none")

                    key = f"{name}|{start_minute}|{recurring}"
                    loaded_keys.add(key)

                    block = TimeBlock(
                        start_minute=start_minute,
                        duration=duration,
                        block_type=b.get("type", "task"),
                        name=name,
                        recurring=recurring
                    )
                    block.completed = b.get("completed", False)

                    if block.block_type == "task" and block.proxy and block.proxy.widget():
                        block.proxy.widget().setChecked(block.completed)

                    if b.get("tag_color"):
                        block.tag_color = QColor(*b["tag_color"])

                    self.scene.addItem(block)
                    block.update_geometry()

                # --- Recurring task fallback (only if not already present) ---
                for b in data.get("blocks", []):
                    if b.get("recurring") == "daily":
                        start_minute = b.get("start_minute", 0)
                        duration = b.get("duration", 60)
                        name = b.get("name", "Untitled")
                        key = f"{name}|{start_minute}|daily"

                        if key not in loaded_keys:
                            block = TimeBlock(
                                start_minute=start_minute,
                                duration=duration,
                                block_type=b.get("type", "task"),
                                name=name,
                                recurring="daily"
                            )
                            self.scene.addItem(block)
                            block.update_geometry()

        except FileNotFoundError:
            pass

        QApplication.instance().settings = self.settings
        self.update_summary_bar()



def task_conflict(task, start_minute, duration, scene):
    end_minute = start_minute + duration
    now_minute = QTime.currentTime().hour() * 60 + QTime.currentTime().minute()

    for item in scene.items():
        if isinstance(item, TimeBlock) and item != task:
            item_start = item.start_minute
            item_end = item.start_minute + item.duration

            if item.block_type == 'break':
                if not (end_minute <= item_start or start_minute >= item_end):
                    return True

            elif item.block_type == 'task' and item.completed and item_start >= now_minute:
                if not (end_minute <= item_start or start_minute >= item_end):
                    return True

    return False





if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = SchedulerApp()
    window.show()
    sys.exit(app.exec_())
