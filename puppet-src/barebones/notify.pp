notify { "Ip address":
  message => $ipaddress
}

notify{ "boardmanufacturer":
  message => $boardmanufacturer
}

notify{ "architecture":
  message => $architecture
}

notify{"operatingsystem":
  message => $operatingsystem
}
notify { "Mac warning":
  message => $operatingsystem ? {
    'Darwin' => "This seems to be a Mac.",
    default => "And I’m a something.",
  }
}
