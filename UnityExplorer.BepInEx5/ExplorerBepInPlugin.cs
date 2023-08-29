using System;
using BepInEx;
using BepInEx.Logging;
using HarmonyLib;
using UnityExplorer.Core;
using UnityExplorer.Core.Config;

namespace UnityExplorer.BepInEx5
{
    [BepInPlugin(ExplorerCore.GUID, "UnityExplorer", ExplorerCore.VERSION)]

    public class ExplorerBepInPlugin : BaseUnityPlugin, IExplorerLoader
    {
        public static ExplorerBepInPlugin Instance;

        public ManualLogSource LogSource => Logger;
        public string UnhollowedModulesFolder => null;
        
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
        
        internal void Awake()
        {
            Init();
        }
    }
}