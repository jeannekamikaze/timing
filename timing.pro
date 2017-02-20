TEMPLATE = lib
CONFIG += shared plugin
CONFIG -= qt

CONFIG(release, debug|release) {
    DESTDIR=$$(SRC)/build/release
    OBJECTS_DIR=$$(SRC)/.obj/release/$$TARGET
}
else {
    DESTDIR=$$(SRC)/build/debug
    OBJECTS_DIR=$$(SRC)/.obj/debug/$$TARGET
}

QMAKE_CXXFLAGS_DEBUG += -DDEBUG
unix: {
    QMAKE_CXXFLAGS += --std=c++11
}
win32: {
    QMAKE_CXXFLAGS += -DNOMINMAX
    QMAKE_CXXFLAGS_DEBUG += /Zi
    QMAKE_LFLAGS_DEBUG += /DEBUG
}

INCLUDEPATH = include $$(SRC)/timer/include
DEPENDPATH = include $$(SRC)/timer/include

HEADERS += include/kxtime.h

SOURCES += src/kxtime.cc
