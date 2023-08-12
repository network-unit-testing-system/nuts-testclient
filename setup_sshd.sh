if [ -n "${ADMIN_PASSWORD-}" ]; then
    echo "admin:$ADMIN_PASSWORD" | chpasswd
fi

ssh-keygen -A