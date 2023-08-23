$BuildType = $args[0]
if ($BuildType -cne "Release" -and $BuildType -cne "Debug")
{
  Write-Output "$BuildType must be ""Release"" or ""Debug""" 
  return -1
}

# ----------- MelonLoader IL2CPP -----------
dotnet build src/UnityExplorer.sln -c ${BuildType}_ML_Cpp
$Path = "${BuildType}\UnityExplorer.MelonLoader.IL2CPP"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /internalize /out:$Path/UnityExplorer.ML.IL2CPP.dll $Path/UnityExplorer.ML.IL2CPP.dll $Path/mcs.dll 
# (cleanup and move files)
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Iced.dll
Remove-Item $Path/Il2CppInterop.Common.dll
Remove-Item $Path/Il2CppInterop.Runtime.dll
Remove-Item $Path/Microsoft.Extensions.Logging.Abstractions.dll
Remove-Item $Path/UnityExplorer.ML.IL2CPP.deps.json
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.ML.IL2CPP.dll -Destination $Path/Mods -Force
Move-Item -Path $Path/UnityExplorer.ML.IL2CPP.pdb -Destination $Path/Mods -Force -ErrorAction SilentlyContinue
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.IL2CPP.dll -Destination $Path/UserLibs -Force
Move-Item -Path $Path/UniverseLib.IL2CPP.pdb -Destination $Path/UserLibs -Force -ErrorAction SilentlyContinue
# (create zip archive)
Remove-Item ${BuildType}/UnityExplorer.MelonLoader.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.MelonLoader.IL2CPP.zip ./*
Set-Location ../..

# ----------- MelonLoader Mono -----------
dotnet build src/UnityExplorer.sln -c ${BuildType}_ML_Mono
$Path = "${BuildType}/UnityExplorer.MelonLoader.Mono"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /internalize /out:$Path/UnityExplorer.ML.Mono.dll $Path/UnityExplorer.ML.Mono.dll $Path/mcs.dll 
# (cleanup and move files)
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.ML.Mono.dll -Destination $Path/Mods -Force
Move-Item -Path $Path/UnityExplorer.ML.Mono.pdb -Destination $Path/Mods -Force -ErrorAction SilentlyContinue
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/UserLibs -Force
Move-Item -Path $Path/UniverseLib.Mono.pdb -Destination $Path/UserLibs -Force -ErrorAction SilentlyContinue
# (create zip archive)
Remove-Item ${BuildType}/UnityExplorer.MelonLoader.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.MelonLoader.Mono.zip ./*
Set-Location ../..

# ----------- BepInEx IL2CPP -----------
dotnet build src/UnityExplorer.sln -c ${BuildType}_BIE_Cpp
$Path = "${BuildType}/UnityExplorer.BepInEx.IL2CPP"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /internalize /out:$Path/UnityExplorer.BIE.IL2CPP.dll $Path/UnityExplorer.BIE.IL2CPP.dll $Path/mcs.dll $Path/Tomlet.dll
# (cleanup and move files)
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Iced.dll
Remove-Item $Path/Il2CppInterop.Common.dll
Remove-Item $Path/Il2CppInterop.Runtime.dll
Remove-Item $Path/Microsoft.Extensions.Logging.Abstractions.dll
Remove-Item $Path/UnityExplorer.BIE.IL2CPP.deps.json
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BIE.IL2CPP.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.IL2CPP.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UnityExplorer.BIE.IL2CPP.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Move-Item -Path $Path/UniverseLib.IL2CPP.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
# (create zip archive)
Remove-Item ${BuildType}/UnityExplorer.BepInEx.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.BepInEx.IL2CPP.zip ./*
Set-Location ../..

# ----------- BepInEx 5 Mono -----------
dotnet build src/UnityExplorer.sln -c ${BuildType}_BIE5_Mono
$Path = "${BuildType}/UnityExplorer.BepInEx5.Mono"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /internalize /out:$Path/UnityExplorer.BIE5.Mono.dll $Path/UnityExplorer.BIE5.Mono.dll $Path/mcs.dll $Path/Tomlet.dll
# (cleanup and move files)
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BIE5.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UnityExplorer.BIE5.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Move-Item -Path $Path/UniverseLib.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
# (create zip archive)
Remove-Item ${BuildType}/UnityExplorer.BepInEx5.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.BepInEx5.Mono.zip ./*
Set-Location ../..

# ----------- BepInEx 6 Mono -----------
dotnet build src/UnityExplorer.sln -c ${BuildType}_BIE6_Mono
$Path = "${BuildType}/UnityExplorer.BepInEx6.Mono"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /internalize /out:$Path/UnityExplorer.BIE6.Mono.dll $Path/UnityExplorer.BIE6.Mono.dll $Path/mcs.dll $Path/Tomlet.dll
# (cleanup and move files)
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BIE6.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UnityExplorer.BIE6.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Move-Item -Path $Path/UniverseLib.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
# (create zip archive)
Remove-Item ${BuildType}/UnityExplorer.BepInEx6.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.BepInEx6.Mono.zip ./*
Set-Location ../..

# ----------- Standalone Mono -----------
dotnet build src/UnityExplorer.sln -c ${BuildType}_STANDALONE_Mono
$Path = "${BuildType}/UnityExplorer.Standalone.Mono"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /internalize /out:$Path/UnityExplorer.Standalone.Mono.dll $Path/UnityExplorer.Standalone.Mono.dll $Path/mcs.dll $Path/Tomlet.dll
# (cleanup and move files)
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item ${BuildType}/UnityExplorer.Standalone.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.Standalone.Mono.zip ./*
Set-Location ../..

# ----------- Standalone IL2CPP -----------
dotnet build src/UnityExplorer.sln -c ${BuildType}_STANDALONE_Cpp
$Path = "${BuildType}/UnityExplorer.Standalone.IL2CPP"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /internalize /out:$Path/UnityExplorer.Standalone.IL2CPP.dll $Path/UnityExplorer.Standalone.IL2CPP.dll $Path/mcs.dll $Path/Tomlet.dll
# (cleanup and move files)
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Iced.dll
Remove-Item $Path/Il2CppInterop.Common.dll
Remove-Item $Path/Il2CppInterop.Runtime.dll
Remove-Item $Path/Microsoft.Extensions.Logging.Abstractions.dll
Remove-Item $Path/UnityExplorer.STANDALONE.IL2CPP.deps.json
Remove-Item ${BuildType}/UnityExplorer.Standalone.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.Standalone.IL2CPP.zip ./*
Set-Location ../..

# ----------- Editor (mono) -----------
$Path1 = "${BuildType}/UnityExplorer.Standalone.Mono"
$Path2 = "UnityEditorPackage/Runtime"
Copy-Item $Path1/UnityExplorer.STANDALONE.Mono.dll -Destination $Path2
Copy-Item $Path1/UniverseLib.Mono.dll -Destination $Path2
Copy-Item $Path1/UnityExplorer.STANDALONE.Mono.pdb -Destination $Path2 -ErrorAction SilentlyContinue
Copy-Item $Path1/UniverseLib.Mono.pdb -Destination $Path2 -ErrorAction SilentlyContinue
Remove-Item ${BuildType}/UnityExplorer.Editor.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.Editor.zip ../../UnityEditorPackage\*
Set-Location ../..
