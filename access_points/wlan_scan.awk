$1 == "BSS" {
    MAC = $2
    wifi[MAC]["enc"] = "Open"
}
$1 == "SSID:" {
    wifi[MAC]["SSID"] = $2
}
$1 == "freq:" {
    wifi[MAC]["freq"] = $NF
}
$1 == "signal:" {
    wifi[MAC]["sig"] = $2
#    wifi[MAC]["sig"] = $2 " " $3
}
$1 == "WPA:" {
    wifi[MAC]["enc"] = "WPA"
}
$1 == "WEP:" {
    wifi[MAC]["enc"] = "WEP"
}
END {
#    printf "%s\t\t%s\t%s\t\t%s\t%s\n","SSID","Frequency","Signal","Encryption","BSS"

    for (w in wifi) {
        printf "%s+%s+%s+%s\n",wifi[w]["SSID"],w,wifi[w]["sig"],wifi[w]["enc"]
    }
}

/^BSS/ {
    mac = gensub ( /^BSS[[:space:]]*([0-9a-fA-F:]+).*?$/, "\\1", "g", $0 );
}
/^[[:space:]]*signal:/ {
    signal = gensub ( /^[[:space:]]*signal:[[:space:]]*(\-?[0-9.]+).*?$/, "\\1", "g", $0 );
}
/^[[:space:]]*WPA:/ {
    wpa = gensub ( /^[[:space:]]*WPA:[[:space:]]*(\-?[0-9.]+).*?$/, "\\1", "g", $0 );
}
/^[[:space:]]*SSID:/ {
    ssid = gensub ( /^[[:space:]]*SSID:[[:space:]]*([^\n]*).*?$/, "\\1", "g", $0 );
#    printf ( "%s:%s:%s:%s\n", ssid, mac, signal, wpa );
}
