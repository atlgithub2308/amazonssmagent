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
