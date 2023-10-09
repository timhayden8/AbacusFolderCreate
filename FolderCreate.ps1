Function AbacusFolderCreate{
    param($year)
    #Sets variables for script. Update file path to business client files, individual client files, business clients, and individual clients. Update year appropriately.
    $Businessfiles = get-childitem "P:\techs\mdc\goes into business client folders"
    $IndividualFiles = get-childitem "P:\techs\mdc\goes into individual client folders"
    $Businessclients = get-childitem "P:\CLIENTS\BUSINESS-TRUSTS"
    $individualclients = get-childitem "P:\CLIENTS\INDIVIDUALS"
    #Foreach loops. Checks if the client has the 2022 folder. if it doesn't, it creates it then moves the files over. if 2022 folder exists, it "noclobber" copies the files over.
    foreach ($client in $businessclients)
    {
        if( -not (test-path ($client.fullname + "\$year")))
        {
            new-item -path $client.fullname -name "$year" -itemtype "Directory"
            robocopy $businessfiles.fullname ($client.fullname + "\$year") /E /XC /XN /XO
        }
        else    
        {
            robocopy ($businessfiles.fullname) ($client.fullname + "\$year") /E /XC /XN /XO
        }
    }
    foreach ($client in $individualclients)
    {
        if( -not (test-path ($client.fullname + "\$year")))
        {
            new-item -path $client.fullname -name "$year" -itemtype "Directory"
            robocopy $individualfiles.fullname ($client.fullname + "\$year") /E /XC /XN /XO
        }
        else    
        {
            robocopy ($individualfiles.fullname) ($client.fullname + "\$year") /E /XC /XN /XO
        }
    }
}
