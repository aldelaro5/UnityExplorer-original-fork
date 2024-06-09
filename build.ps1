$corePathIL2CPP = "Release/UnityExplorer.Core.IL2CPP"
$corePathMono = "Release/UnityExplorer.Core.Mono"

# Build
dotnet build UnityExplorer.sln -c Release_IL2CPP
dotnet build UnityExplorer.sln -c Release_Mono

# ----------- MelonLoader IL2CPP -----------
$Path = "Release\UnityExplorer.MelonLoader.IL2CPP"
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /lib:$corePathIL2CPP /internalize /out:$Path/UnityExplorer.MelonLoader.IL2CPP.dll $corePathIL2CPP/UnityExplorer.Core.IL2CPP.dll $Path/UnityExplorer.MelonLoader.IL2CPP.dll $Path/mcs.dll 
Remove-Item $Path/mcs.dll
Remove-Item $Path/UniverseLib.IL2CPP.xml
Remove-Item $Path/UnityExplorer.MelonLoader.IL2CPP.deps.json
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.MelonLoader.IL2CPP.dll -Destination $Path/Mods -Force
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.IL2CPP.dll -Destination $Path/UserLibs -Force
Remove-Item Release/UnityExplorer.MelonLoader.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
Compress-Archive -Path ./* -DestinationPath ../UnityExplorer.MelonLoader.IL2CPP.zip
Set-Location ../..

# ----------- MelonLoader Mono -----------
$Path = "Release/UnityExplorer.MelonLoader.Mono"
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
Remove-Item $Path/0Harmony.dll
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.MelonLoader.Mono.dll -Destination $Path/Mods -Force
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/UserLibs -Force
Remove-Item Release/UnityExplorer.MelonLoader.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
Compress-Archive -Path ./* -DestinationPath ../UnityExplorer.MelonLoader.Mono.zip
Set-Location ../..

# ----------- BepInEx 6 IL2CPP -----------
$Path = "Release/UnityExplorer.BepInEx6.IL2CPP"
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
Remove-Item Release/UnityExplorer.BepInEx6.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
Compress-Archive -Path ./* -DestinationPath ../UnityExplorer.BepInEx6.IL2CPP.zip
Set-Location ../..

# ----------- BepInEx 5 Mono -----------
$Path = "Release/UnityExplorer.BepInEx5.Mono"
lib/ILRepack.exe /target:library /lib:lib/net35 /lib:$Path /lib:$corePathMono /internalize /out:$Path/UnityExplorer.BepInEx5.Mono.dll $corePathMono/UnityExplorer.Core.Mono.dll $Path/UnityExplorer.BepInEx5.Mono.dll $Path/mcs.dll $Path/Tomlet.dll
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/UniverseLib.Mono.xml
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BepInEx5.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Remove-Item Release/UnityExplorer.BepInEx5.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
Compress-Archive -Path ./* -DestinationPath ../UnityExplorer.BepInEx5.Mono.zip
Set-Location ../..

# ----------- BepInEx 6 Mono -----------
$Path = "Release/UnityExplorer.BepInEx6.Mono"
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
Remove-Item $Path/0Harmony.dll
New-Item -Path "$Path" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "plugins/sinai-dev-UnityExplorer" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.BepInEx6.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Move-Item -Path $Path/UniverseLib.Mono.dll -Destination $Path/plugins/sinai-dev-UnityExplorer -Force
Remove-Item Release/UnityExplorer.BepInEx6.Mono.zip -ErrorAction SilentlyContinue
Set-Location $Path
Compress-Archive -Path ./* -DestinationPath ../UnityExplorer.BepInEx6.Mono.zip
Set-Location ../..

# ----------- Standalone Mono -----------
$Path = "Release/UnityExplorer.Standalone.Mono"
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
Remove-Item Release/UnityExplorer.Standalone.Mono.zip -ErrorAction SilentlyContinue
Remove-Item $Path/0Harmony.dll
Set-Location $Path
Compress-Archive -Path ./* -DestinationPath ../UnityExplorer.Standalone.Mono.zip
Set-Location ../..

# ----------- Standalone IL2CPP -----------
$Path = "Release/UnityExplorer.Standalone.IL2CPP"
Copy-Item $corePathIL2CPP/Tomlet.dll -Destination  $Path
lib/ILRepack.exe /target:library /lib:lib/net6.0 /lib:lib/interop /lib:$Path /lib:$corePathIL2CPP /internalize /out:$Path/UnityExplorer.Standalone.IL2CPP.dll $corePathIL2CPP/UnityExplorer.Core.IL2CPP.dll $Path/UnityExplorer.Standalone.IL2CPP.dll $Path/mcs.dll $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/UnityExplorer.Standalone.IL2CPP.deps.json
Remove-Item $Path/UniverseLib.IL2CPP.xml
Remove-Item Release/UnityExplorer.Standalone.IL2CPP.zip -ErrorAction SilentlyContinue
Set-Location $Path
Compress-Archive -Path ./* -DestinationPath ../UnityExplorer.Standalone.IL2CPP.zip
Set-Location ../..

# ----------- Editor (mono) -----------
$Path1 = "Release/UnityExplorer.Standalone.Mono"
$Path2 = "UnityEditorPackage/Runtime"
Copy-Item $Path1/UnityExplorer.Standalone.Mono.dll -Destination $Path2
Copy-Item $corePathMono/UnityExplorer.Core.Mono.dll -Destination $Path2
Copy-Item $Path1/UniverseLib.Mono.dll -Destination $Path2
Remove-Item Release/UnityExplorer.Editor.zip -ErrorAction SilentlyContinue
Set-Location $Path
Compress-Archive -Path ../../UnityEditorPackage/* -DestinationPath ../UnityExplorer.Editor.zip
Set-Location ../..
