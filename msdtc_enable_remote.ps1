$o = Get-DtcNetworkSetting


if ($o.AuthenticationLevel -ne "NoAuth" -or 
    -not $o.InboundTransactionsEnabled -or 
    -not $o.OutboundTransactionsEnabled -or 
    -not $o.RemoteClientAccessEnabled -or 
    -not $o.RemoteAdministrationAccessEnabled -or 
    -not $o.XATransactionsEnabled -or 
    -not $o.LUTransactionsEnabled) {

    Set-DtcNetworkSetting -AuthenticationLevel NoAuth -InboundTransactionsEnabled:$true -OutboundTransactionsEnabled:$true -RemoteClientAccessEnabled:$true -RemoteAdministrationAccessEnabled:$true -XATransactionsEnabled:$true -LUTransactionsEnabled:$true

}

Get-NetFirewallRule -DisplayGroup "Distributed Transaction Coordinator" | Enable-NetFirewallRule

Get-NetFirewallRule -DisplayGroup "Distributed Transaction Coordinator" | ft
