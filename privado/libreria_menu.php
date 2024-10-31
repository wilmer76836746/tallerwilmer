<?php
//session_start();

// Verifica si la sesión está iniciada
if (isset($_SESSION["sesion_id_rol"])) {

    // Conecta con la base de datos y obtiene el nombre del taller y el logo
    $sql1 = $db->Prepare("SELECT nombres, logo
                          FROM taller
                          WHERE id_taller = 1
                          AND estado <> 'X'                        
                        ");    
    $rs1 = $db->GetAll($sql1);
    $nombres = $rs1[0]["nombres"];
    $logo = $rs1[0]["logo"];

    // Inicializa el contador de visitas
    $counterFile = "counter.txt";
    if (!file_exists($counterFile)) {
        file_put_contents($counterFile, '0');
    }

    // Lee el contador del archivo
    $count = (int)file_get_contents($counterFile);

    // Incrementa el contador
    $count++;

    // Escribe el nuevo valor en el archivo
    file_put_contents($counterFile, $count);

    // Consulta para obtener los accesos del usuario
    $sql = $db->Prepare("SELECT ac.*, op.id_opcion, op.orden, op.contenido, gr.id_grupo, gr.grupo, op.opcion 
                         FROM accesos ac
                         INNER JOIN opciones op ON ac.id_opcion = op.id_opcion
                         INNER JOIN grupos gr ON op.id_grupo = gr.id_grupo
                         WHERE ac.id_rol = '".$_SESSION["sesion_id_rol"]."'
                         AND ac.estado <> 'X'
                         AND op.estado <> 'X'
                         AND gr.estado <> 'X'
                         ORDER BY op.id_grupo, op.orden
                        ");
    $rs = $db->Execute($sql);

    $sql2 = $db->Prepare("SELECT ac.*, op.id_opcion, op.orden, op.contenido, gr.id_grupo, gr.grupo, op.opcion 
                          FROM accesos ac
                          INNER JOIN opciones op ON ac.id_opcion = op.id_opcion
                          INNER JOIN grupos gr ON op.id_grupo = gr.id_grupo
                          WHERE ac.id_rol = '".$_SESSION["sesion_id_rol"]."'
                          AND ac.estado <> 'X'
                          AND op.estado <> 'X'
                          AND gr.estado <> 'X'
                          ORDER BY op.id_grupo, op.orden
                        ");
    $rs2 = $db->Execute($sql2);
    $nick = $_SESSION["sesion_usuario"];
    
} else {
    $rs = "";
    $rs2 = "";
    $nick = "";
}

$dir_php = $_SERVER["PHP_SELF"];    
$cuerp = strpos($dir_php, "listado_tablas.php");

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Web <?php echo $nombres; ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .cabecera {
            background-color: #f8f9fa;
            padding: 10px;
        }
        .titulo {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .usuario {
            font-size: 0.9rem;
        }
        .counter {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #ff5733;
            color: #fff;
            padding: 12px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.5);
            font-size: 1.2em;
            font-weight: bold;
            text-transform: uppercase;
            opacity: 0.9;
            transition: transform 0.3s ease, opacity 0.3s ease;
            cursor: pointer;
        }
        .counter:hover {
            opacity: 1;
            transform: scale(1.1);
        }
        @media (min-width: 992px) {
            .menu-text {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="cabecera">
        <?php
        if ($cuerp == false) {       
            echo "<img src='../tienda_comercail/logos/{$logo}' width='7%' >";    
        } else {
            echo "<img src='privada/tienda_comercail/logos/{$logo}' width='7%' >";
        }
        ?>
        <div class="titulo">
            Sistema Web <?php echo $nombres; ?>
        </div>
        <div class="usuario">
            USUARIO: <b><?php echo $_SESSION["sesion_usuario"]; ?></b> &nbsp;&nbsp; 
            ROL: <b><?php echo $_SESSION["sesion_rol"]; ?></b>
        </div>
    </div>

    <?php if ($nick != ""): ?>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
           
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <span class="navbar-text menu-text" style="margin-left: 10px;">Menú</span>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <?php
                    $grup = "";
                    foreach ($rs as $r => $fila) {
                        if ($grup != $fila["grupo"]) {
                            echo "<li class='nav-item dropdown'>
                                <a class='nav-link dropdown-toggle' href='#' id='navbarDropdown".$fila["id_grupo"]."' role='button' data-bs-toggle='dropdown' aria-expanded='false'>
                                    ".$fila["grupo"]."
                                </a>
                                <ul class='dropdown-menu' aria-labelledby='navbarDropdown".$fila["id_grupo"]."'>";
                            $grup = $fila["grupo"];
                            foreach ($rs2 as $t => $fila2) {
                                if ($grup == $fila2["grupo"]) {
                                    $link = ($cuerp == false || $cuerp == "") ? "../".$fila2["contenido"] : "sis_segundo_2022/".$fila2["contenido"];
                                    echo "<li><a class='dropdown-item' href='".$link."'>".$fila2["opcion"]."</a></li>";
                                }
                            }
                            echo "</ul></li>";
                        }
                    }
                    ?>
                </ul>
                <form class="d-flex">
                    <button class="btn btn-outline-danger" type="button" onclick="location.href='<?php echo ($cuerp == false ? "../../validar.php" : "validar.php"); ?>'">Cerrar Sesión</button>
                </form>
            </div>
        </div>
    </nav>
    <?php endif; ?>

    <div class="counter" id="visitCounter">Visitas: <?php echo $count; ?></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>