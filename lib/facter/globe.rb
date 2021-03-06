
#Linux
##########################################

Facter.add(:a_globepolicy_1_1) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
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

Facter.add(:a_globepolicy_1_1_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'awk -F: \'{ print $1}\' /etc/passwd'
    )
  end
end


Facter.add(:a_globepolicy_1_5) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service sshd |  grep -i ensure |awk -F \' \' \'{ print $3}\''
    )
   
   if ( s == "'running'," )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_1_5_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service sshd'
    )
  end
end

Facter.add(:a_globepolicy_2_9) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'timedatectl |  grep Time'
    )
   
    if ( s == "Time zone: Asia/Singapore \(+08, +0800\)" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_2_9_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'timedatectl'
    )
  end
end

Facter.add(:a_globepolicy_2_a10_ntp) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
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

Facter.add(:a_globepolicy_2_a10_output1_ntp) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'systemctl status chrony'
    )
  end
end

Facter.add(:a_globepolicy_2_a10_output2_ntp) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'puppet resource service chrony'
    )
  end
end

Facter.add(:a_globepolicy_2_b10_dns) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'cat /etc/resolv.conf |grep nameserver | awk -F" " \'{ print $2}\' '
    )
   
    if ( s == "169.254.169.254" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_2_b10_output_dns) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'cat /etc/resolv.conf'
    )
  end
end

Facter.add(:a_globepolicy_2_b16_1) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'crontab -l |grep 6 | awk -F" " \'{ print $6}\' '
    )
   
    if ( s == "/opt/puppetlabs/pe_patch/pe_patch_fact_generation.sh" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_2_b16_output1) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'crontab -l'
    )
  end
end

Facter.add(:a_globepolicy_2_b16_output2a) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service cron |  grep -i ensure |awk -F \' \' \'{ print $3}\''
    )
   
   if ( s == "'running'," )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_2_b16_output2b) do
  confine :osfamily => 'Debian'
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'systemctl status cron'
    )
  end
end

Facter.add(:a_globepolicy_3_2) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    total = Facter::Core::Execution.exec(
      'free -m |grep Mem | awk -F" " \'{ print $2}\' '
    )
    
    used = Facter::Core::Execution.exec(
      'free -m |grep Mem | awk -F" " \'{ print $3}\' '
    )
    
    percent = used.to_i / total.to_i * 100
   
    if ( percent <= 70 )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_3_2_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'free -m'
    )
  end
end

Facter.add(:a_globepolicy_3_5) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    ut = Facter::Core::Execution.exec(
      'uptime | awk -F" " \'{ print $3}\' '
    )
      
    if ( ut.to_i <= 30 )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_3_5_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    Facter::Core::Execution.exec(
      'uptime'
    )
  end
end

Facter.add(:a_globepolicy_3_6) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    c = Facter::Core::Execution.exec(
      'cat /var/log/syslog | grep -i error | wc -l '
    )
      
    if ( c.to_i > 0 )
      :fail
    else
      :pass
    end
  end
end

Facter.add(:a_globepolicy_3_6_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  c = Facter::Core::Execution.exec(
      'cat /var/log/syslog | grep -i error | wc -l '
    )
  
  if ( c.to_i > 0 )
      setcode do
        Facter::Core::Execution.exec(
        'echo "error found!!" ' 
        )
      end
    else
      setcode do
        Facter::Core::Execution.exec(
        'echo "No error " ' 
        )
      end
    end
end

Facter.add(:a_globepolicy_4_1) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s1 = Facter::Core::Execution.exec(
      'cat /etc/cron.d/cron.allow |grep "sysad1"'
    )
    s2 = Facter::Core::Execution.exec(
      'cat /etc/cron.d/cron.allow |grep "sysad2"'
    )
    if ( s1 == 'sysad1' and s2 == 'sysad2' )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_4_1_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'cat /etc/cron.d/cron.allow'
    )
  end
end

Facter.add(:a_globepolicy_4_3) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource package wget |  grep -i ensure |awk -F "\'" \'{ print $2}\''
    )
    if ( s == "present" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_4_3_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource package wget'
    )
  end
end

Facter.add(:a_globepolicy_4_4) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service urandom |  grep -i ensure |awk -F "\'" \'{ print $2}\''
    )
    if ( s == "running" )
      :pass
    else
      :fail
    end
  end
end

Facter.add(:a_globepolicy_4_4_output) do
  confine :osfamily => ['Debian', 'RedHat']
  #confine :operatingsystemmajrelease => '10'
  setcode do
    s = Facter::Core::Execution.exec(
      'puppet resource service urandom'
    )
  end
end


#Windows
##########################################

# Helpers
def f_search (f,pattern)
  f.each do |line|
    if line.match(/#{pattern}/) && !line.match(/#/)
      return :pass
    end
  end
  return :fail
end

def f1_search (f,pattern)
  f.each do |line|
    if line.match(/#{pattern}/)
      return :fail
    end
  end
  return :pass
end

Facter.add(:aaw_globepolicy_1_1) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'wmic service get startname | findstr "demosrvacct" > C:\srvaccount.txt '
    )
    tf = File.readlines('C:\srvaccount.txt')
    f_search(tf,'demosrvacct')
  end
end

Facter.add(:aaw_globepolicy_1_1_output) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'wmic service get name, startname | findstr "demosrvacct" '
    )
  end
end

Facter.add(:aaw_globepolicy_2_1_1) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'cscript /Nologo "C:\Windows\System32\slmgr.vbs" /dli > C:\actstatus.txt '
    )
    tf = File.readlines('C:\actstatus.txt')
    f_search(tf,'Licensed')
  end
end

Facter.add(:aaw_globepolicy_2_1_1_output) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'cscript /Nologo "C:\Windows\System32\slmgr.vbs" /dli '
    )
  end
end

Facter.add(:aaw_globepolicy_2_1_2) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'systeminfo | findstr /B "Domain" > C:\domain.txt '
    )
    tf = File.readlines('C:\domain.txt')
    f_search(tf,'atldemo.com')
  end
end

Facter.add(:aaw_globepolicy_2_1_2_output) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'systeminfo | findstr /B "Domain" '
    )
  end
end

Facter.add(:aaw_globepolicy_2_1_3) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'wmic /namespace:\\root\CIMV2\TerminalServices PATH Win32_TerminalServiceSetting WHERE (__CLASS !="") CALL GetGracePeriodDays 2> C:\rdp.txt '
    )
    tf = File.readlines('C:\rdp.txt')
    f1_search(tf,'ERROR')
  end
end

Facter.add(:aaw_globepolicy_2_1_3_output) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'powershell "cat C:\rdp.txt" '
    )
  end
end

Facter.add(:aaw_globepolicy_3_6) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'powershell "Get-EventLog -LogName System -EntryType Error > C:\err.txt " '
    )
    v = Facter::Core::Execution.exec(
      'powershell "cat C:\err.txt | Select-String \'Error\' > C:\err1.txt " '
    )
   # x = Facter::Core::Execution.exec(
   #   'powershell "Get-Content C:\err1.txt | %{ $_.Split(\' \')[9]; } > C:\err2.txt " '
   # )
    
    x = Facter::Core::Execution.exec(
       'findstr /n . C:\err1.txt | findstr "Error" > C:\err2.txt '
    )
    tf = File.readlines('C:\err2.txt')
    f_search(tf,'Error')
      end
end

Facter.add(:aaw_globepolicy_3_6_output) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'powershell "Get-EventLog -LogName System -EntryType Error" '
    )
  end
end

Facter.add(:aaw_globepolicy_4_3) do
  confine :osfamily => 'windows'
  setcode do
    d = 'C:\Windows\System32\nslookup.exe'
    if File.file?(d)
      :pass
    else
      :fail
    end
  end
end

Facter.add(:aaw_globepolicy_4_3_output) do
  confine :osfamily => 'windows'
  setcode do
    Facter::Core::Execution.exec(
      'powershell "ls C:\Windows\System32\nslookup.exe" '
    )
  end
end

Facter.add(:aaw_globepolicy_6_2) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'wmic service get name, status | findstr "AviraSecurity" > C:\antivirus.txt '
    )
    tf = File.readlines('C:\antivirus.txt')
    f_search(tf,'OK')
  end
end

Facter.add(:aaw_globepolicy_6_2_output) do
  confine :osfamily => 'windows'
  setcode do
    s = Facter::Core::Execution.exec(
      'wmic service get name, status | findstr "AviraSecurity" '
    )
  end
end
