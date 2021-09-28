Facter.add(:globepolicy_1_1) do
  confine :osfamily => 'Debian'
  confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      '/sbin/sysctl kernel.randomize_va_space'
    )
    if ( s != 'kernel.randomize_va_space = 2' )
      :fail
    else
      :pass
      Facter::Core::Execution.exec(
      '/sbin/sysctl kernel.randomize_va_space')
    end
  end
end