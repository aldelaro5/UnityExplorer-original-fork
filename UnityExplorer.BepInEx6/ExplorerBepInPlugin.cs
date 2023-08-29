#if MONO
using BepInEx.Unity.Mono;
#else
using BepInEx.Unity.IL2CPP;
#endif
using System;
using System.IO;
using BepInEx;
using BepInEx.Logging;
using HarmonyLib;
using UnityExplorer.Config;

namespace UnityExplorer.BepInEx6
{
    [BepInPlugin(ExplorerCore.GUID, "UnityExplorer", ExplorerCore.VERSION)]

    public class ExplorerBepInPlugin :
#if MONO
        BaseUnityPlugin
#else
        BasePlugin
#endif
        , IExplorerLoader
    {
        public static ExplorerBepInPlugin Instance;

        public ManualLogSource LogSource
#if MONO
            => Logger;
#else
            => Log;
#endif
        const string IL2CPP_LIBS_FOLDER =
#if CPP
        "interop";
#else
        "";
#endif
        public string UnhollowedModulesFolder => Path.Combine(Paths.BepInExRootPath, IL2CPP_LIBS_FOLDER);

        public ConfigHandler ConfigHandler => _configHandler;
        private BepInExConfigHandler _configHandler;

        public Harmony HarmonyInstance => s_harmony;
        private static readonly Harmony s_harmony = new(ExplorerCore.GUID);

        public string ExplorerFolderName => ExplorerCore.DEFAULT_EXPLORER_FOLDER_NAME;
        public string ExplorerFolderDestination => Paths.PluginPath;

        public Action<object> OnLogMessage => LogSource.LogMessage;
        public Action<object> OnLogWarning => LogSource.LogWarning;
        public Action<object> OnLogError => LogSource.LogError;

        private void Init()
        {
            Instance = this;
            _configHandler = new BepInExConfigHandler();
            ExplorerCore.Init(this);
        }

#if MONO
        internal void Awake()
        {
            Init();
        }
#else
        public override void Load()
        {
            Init();
        }
#endif
    }
}