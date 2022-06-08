bool isDebugMode = false;

void printDebug(Object? object) => isDebugMode ? print('[GMT] $object') : null;
