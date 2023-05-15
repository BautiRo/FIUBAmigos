<!doctype html>
<html class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <asset:javascript src="jquery-3.3.1.min.js" />
        <asset:javascript src="newSelected.js"/>
        <asset:javascript src="amigos/amigos.js"/>
        <asset:javascript src="materias/materias.js"/>
        <title>FIUBAmigos</title>
    </head>
        
    <body>
    <div class="container" style="padding-top: 5rem">
        <div class="row">
            <div class="col">
                <h4>${estudiante.getApellido()} ${estudiante.getNombre()}, ${estudiante.getPadron()}</h4>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <g:if test="${estudiante.getOrientacion() == 'None'}">
                    <h1>${carrera}</h1>
                </g:if>
                <g:if test="${estudiante.getOrientacion() != 'None'}">
                    <h1>${carrera}, ${estudiante.getOrientacion()}</h1>
                </g:if>
            </div>
        </div>
        <br/>

        <div class="row">
            <div class="col-6">
                    <div class="card" style="margin: auto">
                        <div class="card-header">
                            <h4>Materias en curso</h4>
                        </div>
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table class="table table-striped table-bordered table-sm" cellspacing="0"
                                   width="100%">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>C&oacute;digo</th>
                                        <th>Materia</th>
                                        <th>Curso</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each var="cursadaActual" in="${estudiante.getCursadasActuales()}" status="i">
                                        <tr>
                                            <td>${i+1}</td>
                                            <td>${cursadaActual.curso.materia.codigo}</td>
                                            <td>${cursadaActual.curso.materia.nombre}</td>
                                            <td>${cursadaActual.curso.codigo}</td>
                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <br/>
                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Cursos recomendados</h4>
                    </div>
                    <div class="card-body">

                        <label>Priorizar</label>
                        <select id="selectCursosOrden" onchange="ordenarCursosRecomendados()">
                            <option selected="true" disabled="disabled">-Seleccione una opci&oacute;n-</option>
                            <option value="creditos">Créditos</option>
                            <option value="amigos">Amigos anotados</option>
                            <option value="exCompas">Compañeros anotados</option>
                        </select>
                    </div>
                    <div class="table-wrapper-scroll-y my-custom-scrollbar table-responsive">
                        <table id="cursos-recomendados" class="table table-striped table-bordered table-sm" cellspacing="0"
                               width="100%">
                            <thead>
                                <tr>
                                    <th>C&oacute;digo</th>
                                    <th>Materia</th>
                                    <th>Créditos</th>
                                    <th>Curso</th>
                                    <th>Amigos</th>
                                    <th>Compañeros</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each var="cursoRecomendado" in="${cursosRecomendados}" status="i">
                                    <tr>
                                        <td>${cursoRecomendado.materia.codigo}</td>
                                        <td>${cursoRecomendado.materia.nombre}</td>
                                        <td>${cursoRecomendado.materia.creditos}</td>
                                        <td>${cursoRecomendado.curso.codigo}</td>
                                        <td>${cursoRecomendado.amigos}</td>
                                        <td>${cursoRecomendado.companieros}</td>
                                        <td>
                                            <button onclick="agregarMateriaEnCurso('${cursoRecomendado.materia.codigo}', '${cursoRecomendado.materia.nombre}', '${cursoRecomendado.curso.codigo}')" type="button" class="btn">
                                                <asset:image src="inscription24.png" alt="Inscribirme"/>
                                            </button>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Compañeros recomendados</h4>
                    </div>
                    <div class="card-body">
                        <label>Priorizar </label>
                        <select id="selectAmigosOrden" onchange="ordenarAmigosRecomendados()">
                            <option selected="true" disabled="disabled">-Seleccione una opci&oacute;n-</option>
                            <option value="cursadas">Cursadas compartidas</option>
                            <option value="promedio">Promedio</option>
                            <option value="amigos">Amigos en comun</option>
                        </select>
                    </div>
                    <div class="table-wrapper-scroll-y my-custom-scrollbar">
                        <table id="compas-recomendados" class="table table-striped table-bordered table-sm" cellspacing="0"
                               width="100%">
                            <thead>
                                <tr>
                                    <th>Nombre y apellido</th>
                                    <th>Promedio</th>
                                    <th>Cursadas</th>
                                    <th>Amigos en común</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each var="compaAntiguo" in="${compasAntiguos}" status="i">
                                    <tr>
                                        <td>${compaAntiguo.estudiante.nombre} ${compaAntiguo.estudiante.apellido}</td>
                                        <td>${compaAntiguo.estudiante.getPromedio()}</td>
                                        <td>${compaAntiguo.getCantidadDeCursadasCompartidas()}</td>
                                        <td>${compaAntiguo.amigosEnComun}</td>
                                        <td>
                                            <button onclick="enviarSolicitud('${compaAntiguo.estudiante.apellido}, ${compaAntiguo.estudiante.nombre} #${compaAntiguo.estudiante.padron}' )" type="button" id="send-form" class="btn">
                                                <asset:image src="sendrequest24.png" alt="Enviar"/>
                                            </button>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
                <br/>
                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Compañeros de cursada actual</h4>
                    </div>
                    <div class="card-body">
                        <label>Priorizar</label>
                        <select id="selectCompasOrden" onchange="ordenarCompasActuales()">
                            <option selected="true" disabled="disabled">-Seleccione una opci&oacute;n-</option>
                            <option value="cursadas">Materias compartidas</option>
                            <option value="promedio">Promedio</option>
                            <option value="amigos">Amigos en común</option>
                        </select>
                    </div>
                    <div class="table-wrapper-scroll-y my-custom-scrollbar table-responsive">
                        <table id="compas-actuales"  class="table table-striped table-bordered table-sm" cellspacing="0"
                               width="100%">
                                <thead>
                                    <tr>
                                        <th>Nombre y apellido</th>
                                        <th>Promedio</th>
                                        <th>Materias compartidas</th>
                                        <th>Amigos en común</th>
                                        <th></th>

                                    </tr>
                                </thead>
                            <tbody>
                                <g:each var="compaActual" in="${compasActuales}" status="i">
                                    <tr>
                                        <td>${compaActual.estudiante.nombre} ${compaActual.estudiante.apellido}</td>
                                        <td>${compaActual.estudiante.getPromedio()}</td>
                                        <td><g:each var="cursada" in="${compaActual.cursadasCompartidas}" status="j">
                                            <g:if test="${j >= 1}">, </g:if>
                                            ${cursada}
                                        </g:each></td>
                                        <td>${compaActual.amigosEnComun}</td>
                                        <td>
                                            <g:if test="${!compaActual.amigo}">
                                                <button onclick="enviarSolicitud('${compaActual.estudiante.apellido}, ${compaActual.estudiante.nombre} #${compaActual.estudiante.padron}' )" type="button" id="send-form" class="btn">
                                                <asset:image src="sendrequest24.png" alt="Enviar"/>
                                            </g:if>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
