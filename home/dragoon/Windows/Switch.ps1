$port = New-Object System.IO.Ports.SerialPort('COM2',115200,'None',8, 'one')
$port.Open()
$port.WriteLine("win10 host")
$port.Close()