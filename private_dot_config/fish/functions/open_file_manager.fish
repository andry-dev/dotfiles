function open_file_manager
    dbus-send --session \
              --dest=org.freedesktop.FileManager1 \
              --type=method_call \
              /org/freedesktop/FileManager1 \
              org.freedesktop.FileManager1.ShowFolders \
              array:string:"file://$PWD" \
              string:""
end
