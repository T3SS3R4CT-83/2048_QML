#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>

static const unsigned char qt_resource_tree[] = {
0,
0,0,0,0,2,0,0,0,2,0,0,0,1,0,0,0,
8,0,2,0,0,0,2,0,0,0,6,0,0,0,70,0,
2,0,0,0,3,0,0,0,3,0,0,0,48,0,0,0,
0,0,1,0,0,0,0,0,0,0,116,0,0,0,0,0,
1,0,0,0,0,0,0,0,82,0,0,0,0,0,1,0,
0,0,0,0,0,0,48,0,0,0,0,0,1,0,0,0,
0,0,0,0,18,0,0,0,0,0,1,0,0,0,0};
static const unsigned char qt_resource_names[] = {
0,
1,0,0,0,47,0,47,0,2,0,0,7,19,0,106,0,
115,0,12,12,111,81,115,0,71,0,97,0,109,0,101,0,
76,0,111,0,103,0,105,0,99,0,46,0,106,0,115,0,
8,0,40,95,92,0,84,0,105,0,108,0,101,0,46,0,
113,0,109,0,108,0,3,0,0,120,60,0,113,0,109,0,
108,0,14,11,113,252,92,0,77,0,97,0,105,0,110,0,
87,0,105,0,110,0,100,0,111,0,119,0,46,0,113,0,
109,0,108,0,14,1,88,147,28,0,80,0,108,0,97,0,
121,0,103,0,114,0,111,0,117,0,110,0,100,0,46,0,
113,0,109,0,108};
static const unsigned char qt_resource_empty_payout[] = { 0, 0, 0, 0, 0 };
QT_BEGIN_NAMESPACE
extern Q_CORE_EXPORT bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
QT_END_NAMESPACE
namespace QmlCacheGeneratedCode {
namespace _qml_Playground_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_Tile_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _js_Tile_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _js_GameLogic_js { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_MainWindow_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/Playground.qml"), &QmlCacheGeneratedCode::_qml_Playground_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/Tile.qml"), &QmlCacheGeneratedCode::_qml_Tile_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/js/Tile.qml"), &QmlCacheGeneratedCode::_js_Tile_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/js/GameLogic.js"), &QmlCacheGeneratedCode::_js_GameLogic_js::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/MainWindow.qml"), &QmlCacheGeneratedCode::_qml_MainWindow_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.version = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
QT_PREPEND_NAMESPACE(qRegisterResourceData)(/*version*/0x01, qt_resource_tree, qt_resource_names, qt_resource_empty_payout);
}
const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_resources)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_resources))
int QT_MANGLE_NAMESPACE(qCleanupResources_resources)() {
    return 1;
}
