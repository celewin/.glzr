function Toggle-TaskbarVisibility {
    # Füge Typdefinitionen für die Windows API hinzu
    Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;
        public class Taskbar {
            [DllImport("user32.dll")]
            public static extern int FindWindow(string className, string windowText);
            [DllImport("user32.dll")]
            public static extern int ShowWindow(int hwnd, int command);
        }
"@

    # Haupt-Taskleiste
    $hwndPrimary = [Taskbar]::FindWindow("Shell_TrayWnd", "")
    
    # Sekundäre Taskleisten (auf weiteren Bildschirmen)
    $hwndSecondary = [Taskbar]::FindWindow("Shell_SecondaryTrayWnd", "")

    # Überprüfen, ob die Taskleiste sichtbar ist
    $isPrimaryVisible = ($hwndPrimary -ne 0) -and ([Taskbar]::ShowWindow($hwndPrimary, 0) -eq 24)
    $isSecondaryVisible = ($hwndSecondary -ne 0) -and ([Taskbar]::ShowWindow($hwndSecondary, 0) -eq 24)
    # Toggle der Sichtbarkeit der Taskleiste
    if ($isPrimaryVisible -and $isSecondaryVisible) {
        # Taskleiste ausblenden
        [Taskbar]::ShowWindow($hwndPrimary, 0)
        if ($hwndSecondary -ne 0) {
            [Taskbar]::ShowWindow($hwndSecondary, 0)
        }
    }
    else {
        # Taskleiste einblenden
        [Taskbar]::ShowWindow($hwndPrimary, 1)
        if ($hwndSecondary -ne 0) {
            [Taskbar]::ShowWindow($hwndSecondary, 1)
        }
    }
}

# Taskleiste auf allen Bildschirmen ein- oder ausblenden je nach Modus
Toggle-TaskbarVisibility
