Facter.add(:globepolicy_1_1) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    s1 = Facter::Core::Execution.exec(
      'awk -F: \'{ print $1}\' /etc/passwd |grep "sysad1"'
    )
    s2 = Facter::Core::Execution.exec(
      'awk -F: \'{ print $1}\' /etc/passwd |grep "sysad2"'
    )
    if ( s1 == 'sysad1' and s2 == 'sysad2' )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:globepolicy_1_1_output) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'awk -F: \'{ print $1}\' /etc/passwd'
    )
  end
end


Facter.add(:globepolicy_1_5) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service sshd |  grep -i sshd |awk -F \' \' \'{ print $3}\''
    )
   
    if ( s == "'sshd':" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:globepolicy_1_5_output) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service sshd'
    )
  end
end

Facter.add(:globepolicy_2_9) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'timedatectl |  grep Time'
    )
   
    if ( s == "Time zone: Etc/UTC \(UTC, +0000\)" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:globepolicy_2_9_output) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'timedatectl'
    )
  end
end

Facter.add(:globepolicy_2_10) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service chrony |  grep -i ensure | awk -F"\'" \'{ print $2}\''
    )
   
    if ( s == "running" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:globepolicy_2_10_output1) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'systemctl status chrony'
    )
  end
end

Facter.add(:globepolicy_2_10_output2) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'puppet resource service chrony'
    )
  end
end
