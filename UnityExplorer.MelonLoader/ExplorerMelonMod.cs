using System;
using System.IO;
using MelonLoader;
using MelonLoader.Utils;
using UnityExplorer.Core;
using UnityExplorer.Core.Config;
using UnityExplorer.MelonLoader;

#if CPP
[assembly: MelonPlatformDomain(MelonPlatformDomainAttribute.CompatibleDomains.IL2CPP)]
#else
[assembly: MelonPlatformDomain(MelonPlatformDomainAttribute.CompatibleDomains.MONO)]
#endif

[assembly: MelonInfo(typeof(ExplorerMelonMod), ExplorerCore.NAME, ExplorerCore.VERSION, ExplorerCore.AUTHOR)]
[assembly: MelonGame]
[assembly: MelonColor(0xff, 0x0, 0x8b, 0x08b)]

namespace UnityExplorer.MelonLoader
{
    public class ExplorerMelonMod : MelonMod, IExplorerLoader
    {
        public string ExplorerFolderName => ExplorerCore.DEFAULT_EXPLORER_FOLDER_NAME;
        public string ExplorerFolderDestination => MelonEnvironment.ModsDirectory;

        public string UnhollowedModulesFolder => Path.Combine(
            Path.GetDirectoryName(MelonEnvironment.ModsDirectory),
            Path.Combine("MelonLoader", "Managed"));

        public ConfigHandler ConfigHandler => _configHandler;
        public MelonLoaderConfigHandler _configHandler;

        public Action<object> OnLogMessage => LoggerInstance.Msg;
        public Action<object> OnLogWarning => LoggerInstance.Warning;
        public Action<object> OnLogError   => LoggerInstance.Error;

        public override void OnInitializeMelon()
        {
            _configHandler = new MelonLoaderConfigHandler();
            ExplorerCore.Init(this);
        }
    }
}