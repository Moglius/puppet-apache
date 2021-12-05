# frozen_string_literal: true

Facter.add(:apache_processes) do
  confine :kernel => 'Linux'
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    case Facter.value(:osfamily)
    when 'Debian'
      Facter::Core::Execution.execute('pgrep apache2 | wc -l')
    when 'Red_Hat'
      Facter::Core::Execution.execute('pgrep httpd | wc -l')
    end
  end
end
