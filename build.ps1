$BuildType = $args[0]
if ($BuildType -cne "Release" -and $BuildType -cne "Debug")
{
  Write-Output "$BuildType must be ""Release"" or ""Debug"""
  return
}

$corePathIL2CPP = "${BuildType}\UnityExplorer.Core.IL2CPP"
$corePathMono = "${BuildType}\UnityExplorer.Core.Mono"

# Build
dotnet build UnityExplorer.sln -c ${BuildType}_IL2CPP
dotnet build UnityExplorer.sln -c ${BuildType}_Mono
$Path = "${BuildType}\UnityExplorer.MelonLoader.IL2CPP"

# ----------- MelonLoader IL2CPP -----------
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /lib:$corePathIL2CPP /internalize /out:$Path/UnityExplorer.MelonLoader.IL2CPP.dll $corePathIL2CPP/UnityExplorer.Core.IL2CPP.dll $Path/UnityExplorer.MelonLoader.IL2CPP.dll $Path/mcs.dll 
Remove-Item $Path/mcs.dll
Remove-Item $Path/UniverseLib.IL2CPP.xml
Remove-Item $Path/UnityExplorer.MelonLoader.IL2CPP.deps.json
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.MelonLoader.IL2CPP.dll -Destination $Path/Mods -Force
Move-Item -Path $Path/UnityExplorer.MelonLoader.IL2CPP.pdb -Destination $Path/Mods -Force -ErrorAction SilentlyContinue
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.IL2CPP.dll -Destination $Path/UserLibs -Force
Move-Item -Path $Path/UniverseLib.IL2CPP.pdb -Destination $Path/UserLibs -Force -ErrorAction SilentlyContinue
Remove-Item ${BuildType}/UnityExplorer.MelonLoader.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.MelonLoader.IL2CPP.zip ./*
Set-Location ../..

# ----------- MelonLoader Mono -----------
$Path = "${BuildType}/UnityExplorer.MelonLoader.Mono"
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /lib:$corePathMono /internalize /out:$Path/UnityExplorer.MelonLoader.Mono.dll $corePathMono/UnityExplorer.Core.Mono.dll $Path/UnityExplorer.MelonLoader.Mono.dll $Path/mcs.dll 
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/MelonLoader.dll
Remove-Item $Path/Mono.Cecil.dll
Remove-Item $Path/Mono.Cecil.Pdb.dll
Remove-Item $Path/Mono.Cecil.Mdb.dll
Remove-Item $Path/Mono.Cecil.Rocks.dll
Remove-Item $Path/MonoMod.RuntimeDetour.dll
Remove-Item $Path/MonoMod.Utils.dll
Remove-Item $Path/UniverseLib.Mono.xml
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.MelonLoader.Mono.dll -Destination $Path/Mods -Force
Move-Item -Path $Path/UnityExplorer.MelonLoader.Mono.pdb -Destination $Path/Mods -Force -ErrorAction SilentlyContinue
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/UserLibs -Force
Move-Item -Path $Path/UniverseLib.Mono.pdb -Destination $Path/UserLibs -Force -ErrorAction SilentlyContinue
Remove-Item ${BuildType}/UnityExplorer.MelonLoader.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.MelonLoader.Mono.zip ./*
Set-Location ../..

# ----------- BepInEx 6 IL2CPP -----------
$Path = "${BuildType}/UnityExplorer.BepInEx6.IL2CPP"
Copy-Item $corePathIL2CPP/Tomlet.dll -Destination  $Path
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /lib:$corePathIL2CPP /internalize /out:$Path/UnityExplorer.BepInEx6.IL2CPP.dll $corePathIL2CPP/UnityExplorer.Core.IL2CPP.dll $Path/UnityExplorer.BepInEx6.IL2CPP.dll $Path/mcs.dll $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/UniverseLib.IL2CPP.xml
Remove-Item $Path/UnityExplorer.BepInEx6.IL2CPP.deps.json
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BepInEx6.IL2CPP.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.IL2CPP.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UnityExplorer.BepInEx6.IL2CPP.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Move-Item -Path $Path/UniverseLib.IL2CPP.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Remove-Item ${BuildType}/UnityExplorer.BepInEx6.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.BepInEx6.IL2CPP.zip ./*
Set-Location ../..

# ----------- BepInEx 5 Mono -----------
$Path = "${BuildType}/UnityExplorer.BepInEx5.Mono"
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /lib:$corePathMono /internalize /out:$Path/UnityExplorer.BepInEx5.Mono.dll $corePathMono/UnityExplorer.Core.Mono.dll $Path/UnityExplorer.BepInEx5.Mono.dll $Path/mcs.dll $Path/Tomlet.dll
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/UniverseLib.Mono.xml
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BepInEx5.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UnityExplorer.BepInEx5.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Move-Item -Path $Path/UniverseLib.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Remove-Item ${BuildType}/UnityExplorer.BepInEx5.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.BepInEx5.Mono.zip ./*
Set-Location ../..

# ----------- BepInEx 6 Mono -----------
$Path = "${BuildType}/UnityExplorer.BepInEx6.Mono"
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /lib:$corePathMono /internalize /out:$Path/UnityExplorer.BepInEx6.Mono.dll $corePathMono/UnityExplorer.Core.Mono.dll $Path/UnityExplorer.BepInEx6.Mono.dll $Path/mcs.dll $Path/Tomlet.dll
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Mono.Cecil.dll
Remove-Item $Path/Mono.Cecil.Pdb.dll
Remove-Item $Path/Mono.Cecil.Mdb.dll
Remove-Item $Path/Mono.Cecil.Rocks.dll
Remove-Item $Path/MonoMod.RuntimeDetour.dll
Remove-Item $Path/MonoMod.Utils.dll
Remove-Item $Path/UniverseLib.Mono.xml
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BepInEx6.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UnityExplorer.BepInEx6.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Move-Item -Path $Path/UniverseLib.Mono.pdb -Destination $Path/plugins/sinai-dev-UnityExplorer -Force -ErrorAction SilentlyContinue
Remove-Item ${BuildType}/UnityExplorer.BepInEx6.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.BepInEx6.Mono.zip ./*
Set-Location ../..

# ----------- Standalone Mono -----------
$Path = "${BuildType}/UnityExplorer.Standalone.Mono"
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /lib:$corePathMono /internalize /out:$Path/UnityExplorer.Standalone.Mono.dll $corePathMono/UnityExplorer.Core.Mono.dll $Path/UnityExplorer.Standalone.Mono.dll $Path/mcs.dll $Path/Tomlet.dll
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Mono.Cecil.dll
Remove-Item $Path/Mono.Cecil.Pdb.dll
Remove-Item $Path/Mono.Cecil.Mdb.dll
Remove-Item $Path/Mono.Cecil.Rocks.dll
Remove-Item $Path/MonoMod.RuntimeDetour.dll
Remove-Item $Path/MonoMod.Utils.dll
Remove-Item $Path/UniverseLib.Mono.xml
Remove-Item ${BuildType}/UnityExplorer.Standalone.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.Standalone.Mono.zip ./*
Set-Location ../..

# ----------- Standalone IL2CPP -----------
$Path = "${BuildType}/UnityExplorer.Standalone.IL2CPP"
Copy-Item $corePathIL2CPP/Tomlet.dll -Destination  $Path
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /lib:$corePathIL2CPP /internalize /out:$Path/UnityExplorer.Standalone.IL2CPP.dll $corePathIL2CPP/UnityExplorer.Core.IL2CPP.dll $Path/UnityExplorer.Standalone.IL2CPP.dll $Path/mcs.dll $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/UnityExplorer.Standalone.IL2CPP.deps.json
Remove-Item $Path/UniverseLib.IL2CPP.xml
Remove-Item ${BuildType}/UnityExplorer.Standalone.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.Standalone.IL2CPP.zip ./*
Set-Location ../..

# ----------- Editor (mono) -----------
$Path1 = "${BuildType}/UnityExplorer.Standalone.Mono"
$Path2 = "UnityEditorPackage/Runtime"
Copy-Item $Path1/UnityExplorer.Standalone.Mono.dll -Destination $Path2
Copy-Item $corePathMono/UnityExplorer.Core.Mono.dll -Destination $Path2
Copy-Item $Path1/UniverseLib.Mono.dll -Destination $Path2
Copy-Item $Path1/UnityExplorer.Standalone.Mono.pdb -Destination $Path2 -ErrorAction SilentlyContinue
Copy-Item $Path1/UniverseLib.Mono.pdb -Destination $Path2 -ErrorAction SilentlyContinue
Remove-Item ${BuildType}/UnityExplorer.Editor.zip -ErrorAction SilentlyContinue
Set-Location $Path
7z a ../UnityExplorer.Editor.zip ../../UnityEditorPackage\*
Set-Location ../..
