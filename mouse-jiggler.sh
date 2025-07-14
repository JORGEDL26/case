# #!/bin/bash

# echo "mouse-jiggler 🐭"

# _dev=$(ls -1 /dev/input/by-id/*event-mouse | tail -1)
# [ -z "${_dev}" ] && echo "Cannot find mouse event device" && exit 1
# echo "Using ${_dev}"
# while [ true ]; do
#     sleep ${1-30}
#     /usr/bin/evemu-event ${_dev} --type EV_REL --code REL_X --value ${2-10} --sync
#     /usr/bin/evemu-event ${_dev} --type EV_REL --code REL_X --value -${2-10} --sync
# done

#!/bin/bash

echo "mouse-jiggler 🐭"

# 1. Tenta usar mouse externo (via by-id)
_dev=$(ls -1 /dev/input/by-id/*event-mouse 2>/dev/null | tail -1)

# 2. Se não achou, usa o emulador interno (identificado como mouse)
if [ -z "$_dev" ]; then
    _dev="/dev/input/event3"
    echo "🔍 Mouse externo não encontrado. Usando mouse embutido ($_dev)"
else
    echo "✅ Usando mouse externo ($_dev)"
fi

# 3. Verifica se o dispositivo existe
if [ ! -e "$_dev" ]; then
    echo "❌ Dispositivo $_dev não existe."
    exit 1
fi

# 4. Loop de movimento
while true; do
    sleep "1"
    /usr/bin/evemu-event "$_dev" --type EV_REL --code REL_X --value "300" --sync
    /usr/bin/evemu-event "$_dev" --type EV_REL --code REL_X --value "-300" --sync
done
