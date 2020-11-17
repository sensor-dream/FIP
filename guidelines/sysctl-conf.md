# SYSCTL.CONF

## Tuning TCP stack

### Sysctl parameters that allow you to increase the size of the ARP cache

`Installation using parameters in a file, for example:`

```bash
#!/bin/env bash

  if [[ ! -f /etc/sysctl.d/99-main-sysctl.conf ]]; then
    cat <<EOF | sudo tee /etc/sysctl.d/99-main-sysctl.conf >/dev/null
# gc_thresh1 — the minimum number of entries that should be in the ARP cache.
# If the number of entries is less than this value, the garbage collector will not clear the ARP cache.
# (def. 128)
net.ipv4.neigh.default.gc_thresh1 = 1024
# gc_thresh2 - soft limit on the number of entries in the ARP cache.
# If the number of entries reaches this value, the garbage collector starts within 5 seconds.
# (def. 512)
net.ipv4.neigh.default.gc_thresh2 = 2048
# gc_thresh3 - hard limit on the number of entries in the ARP cache.
# If the number of records reaches this value, the garbage collector starts immediately.
# (def. 1024)
net.ipv4.neigh.default.gc_thresh3 = 4096
EOF
  fi

  # Return the values of variables to the state saved in files.
  sudo sysctl --system

```

`or or using the sysctl utility:`

```bash
#!/bin/env bash

  # gc_thresh1 — the minimum number of entries that should be in the ARP cache.
  # If the number of entries is less than this value, the garbage collector will not clear the ARP cache.
  # (def. 128)
  sudo sysctl -w net.ipv4.neigh.default.gc_thresh1=1024

  # gc_thresh2 - soft limit on the number of entries in the ARP cache.
  # If the number of entries reaches this value, the garbage collector starts within 5 seconds.
  # (def. 512)
  sudo sysctl -w net.ipv4.neigh.default.gc_thresh2=2048

  # gc_thresh3 - hard limit on the number of entries in the ARP cache.
  # If the number of records reaches this value, the garbage collector starts immediately.
  # (def. 1024)
  sudo sysctl -w net.ipv4.neigh.default.gc_thresh3=4096

  # Return the values of variables to the state saved in files and delete your changes.
  # sudo sysctl --system

```
