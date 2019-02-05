# Inspired by https://github.com/ideamonk/Rambola/blob/master/src/helper.sh

function ramdisk --argument-names size_gibibytes
  if test -z "$size_gibibytes"
    echo 'You must specify a size in gibibytes'
    return 1
  end

  if type --quiet diskutil
    echo "Mounting ramdisk at /Volumes/ramdisk with size $size_gibibytes GiB"
    set --local block_size (math --scale=0 "2048 * 1024 * $size_gibibytes")
    set --local disk (string trim (hdiutil attach -nomount ram://$block_size))
    diskutil eraseVolume HFS+ ramdisk $disk
    return
  end

  echo "Mounting ramdisk at /ramdisk with size $size_gibibytes GiB"
  set --local size_bytes (math --scale=0 "1024 ^ 3 * $size_gibibytes")
  sudo mkdir -p /ramdisk
  and sudo mount -t tmpfs -o size=$size_bytes tmpfs /ramdisk
end
