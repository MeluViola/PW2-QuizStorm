<?php
use chillerlan\QRCode\QRCode;
use chillerlan\QRCode\QROptions;
class QRHelper
{
    public static function generarQR($username, $profileLink)
    {
        $options = new QROptions([
            'outputType' => QRCode::OUTPUT_IMAGE_PNG,
            'eccLevel' => QRCode::ECC_L,
        ]);

        $qrCode = new QRCode($options);

        // Directorio donde se almacenarán los QR (asegúrate de que exista y tenga permisos de escritura)
        $qrDirectory = __DIR__ . "/../public/images/qr/";
        if (!is_dir($qrDirectory)) {
            mkdir($qrDirectory, 0755, true);
        }

        // Ruta del archivo QR basado en el nombre de usuario
        $qrFilePath = $qrDirectory . $username . ".png";

        // Generar el QR y guardarlo en el archivo
        $qrCode->render($profileLink, $qrFilePath);

        // Retorna la ruta relativa del QR para usar en la vista
        return "/images/qr/" . $username . ".png";
    }
}

