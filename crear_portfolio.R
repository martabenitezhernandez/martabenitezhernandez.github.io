# ------------------------------------------------------------------
# crear_portfolio.R
# Genera index.html (junto a foto.jpg), la web de portfolio de Marta Benítez Hernández.
#
# Uso
#   install.packages("htmltools")   # solo la primera vez
#   source("crear_portfolio.R")     # crea index.html en la carpeta actual
#
# El archivo debe estar guardado en UTF-8 para que salgan bien las tildes
# (en RStudio, File > Save with Encoding > UTF-8).
#
# Para cambiar textos o proyectos basta con editar la sección CONTENIDO.
# El resultado es un único archivo HTML que puedes subir a GitHub Pages,
# Netlify o cualquier hosting estático.
# ------------------------------------------------------------------

library(htmltools)

# =========================== CONTENIDO ============================

persona <- list(
  nombre    = "Marta Benítez Hernández",
  rol       = "Titulada superior en INGENIO (CSIC–UPV). Desarrollo herramientas de recogida, análisis y visualización de datos sobre ciencia, medios y redes sociales.",
  email     = "martabenitezhernandez@gmail.com",
  foto      = "foto.jpg",   # imagen en la misma carpeta que index.html
  actualizado = "octubre 2026"
)

# Enlaces de la cabecera. Añade o quita filas libremente.
enlaces <- list(
  list(texto = "GitHub", url = "https://github.com/martabenitezhernandez")
  # list(texto = "LinkedIn", url = "https://www.linkedin.com/in/..."),
  # list(texto = "ORCID",    url = "https://orcid.org/...")
)

# Cada elemento es un párrafo de la biografía.
biografia <- c(
  "Estudié el Doble Grado en Ingeniería Informática y Matemáticas en la Universidad de Granada.",
  "Durante este periodo hice un año de prácticas repartido en dos estancias de seis meses en empresas distintas, una en el CEPRUD y otra en EC3metrics.",
  "Desde marzo de 2026 trabajo como titulada superior en INGENIO (CSIC–UPV), en Valencia, dentro del programa Momentum del CSIC. Desde entonces participo en los proyectos que aparecen más abajo.",
  "Gracias a Momentum estoy cursando el Máster Universitario en Ciencia de Datos de la UOC, el campo hacia el que quiero orientar mi carrera profesional."
)

# Proyectos. Deja enlace = NULL si todavía no está publicado.
proyectos <- list(
  list(
    titulo   = "Global Health Priorities",
    contexto = "INGENIO · programa Momentum",
    fecha    = "2026",
    estado   = "Publicado",
    descripcion = "Aplicación interactiva que presenta los resultados de un preprint de INGENIO sobre el desajuste entre la carga de enfermedad, la atención pública en Wikipedia y el esfuerzo investigador. Permite explorar los datos desde un menú lateral con filtros de selección y gráficos interactivos, entre ellos un triángulo ternario.",
    etiquetas = c("R", "Shiny", "Visualización de datos"),
    enlace = "https://momentumingenio.shinyapps.io/global-health-priorities/",
    enlace_texto = "Ver la aplicación"
  ),
  list(
    titulo   = "Translational Triangle",
    contexto = "INGENIO · programa Momentum",
    fecha    = "2026",
    estado   = "Publicado",
    descripcion = "Herramienta en Python que mide hasta qué punto la investigación biomédica de un grupo de investigadores acaba influyendo en la investigación con personas. Descarga los datos de las APIs de Scopus y PubMed, los limpia y cruza, calcula nuevas métricas por investigador y presenta los resultados en un gráfico interactivo.",
    etiquetas = c("Python", "pandas", "Plotly", "Scopus API", "PubMed API", "MeSH"),
    enlace = "https://github.com/martabenitezhernandez/translational-triangle",
    enlace_texto = "Ver el repositorio"
  ),
  list(
    titulo   = "Science of Consciousness",
    contexto = "INGENIO · programa Momentum",
    fecha    = "2026",
    estado   = "En curso",
    descripcion = "Estudio de cómo se vivió en Twitter la polémica que se desató en 2023 tras una carta que calificaba de pseudociencia la teoría de la información integrada de la consciencia. Desarrollé el proyecto completo, desde la captura de los tweets y su procesado hasta la construcción de una red de interacciones entre usuarios. Sobre esa red apliqué análisis de grafos y algoritmos de detección de comunidades, y modelos de temas (LDA y BERTopic) para identificar de qué se hablaba, todo ello integrado en una aplicación interactiva en Streamlit.",
    etiquetas = c("Python", "Streamlit", "NLP", "Análisis de redes"),
    enlace = NULL,
    enlace_texto = NULL
  )
)

archivo_salida <- "index.html"

# ============================ DISEÑO ==============================

css <- r"(
:root {
  --bg: #f6f7f9; --surface: #ffffff; --fg: #1b2230; --muted: #5b6577; --line: #dde1e8;
  --accent: #2f4fb8; --ok: #2f8a7a; --wip: #b06a22;
  --v-a: #c2662d; --v-c: #2f8a7a; --v-h: #2f4fb8;
  --display: "Newsreader", Georgia, "Times New Roman", serif;
  --body: "IBM Plex Sans", system-ui, -apple-system, "Segoe UI", sans-serif;
  --mono: "IBM Plex Mono", ui-monospace, Menlo, monospace;
}
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --bg: #12151c; --surface: #191d26; --fg: #e6e9ef; --muted: #9aa3b4; --line: #2a303c;
    --accent: #8ea6ff; --ok: #6cc6b5; --wip: #e5a764;
    --v-a: #e59a64; --v-c: #6cc6b5; --v-h: #8ea6ff; color-scheme: dark;
  }
}
:root[data-theme="dark"] {
  --bg: #12151c; --surface: #191d26; --fg: #e6e9ef; --muted: #9aa3b4; --line: #2a303c;
  --accent: #8ea6ff; --ok: #6cc6b5; --wip: #e5a764;
  --v-a: #e59a64; --v-c: #6cc6b5; --v-h: #8ea6ff; color-scheme: dark;
}
* { box-sizing: border-box; }
body { margin: 0; background: var(--bg); color: var(--fg); font-family: var(--body); font-size: 1rem; line-height: 1.65; }
.wrap {
  max-width: 46rem; margin: 0 auto;
  padding-left: max(16px, env(safe-area-inset-left, 0px));
  padding-right: max(16px, env(safe-area-inset-right, 0px));
  padding-block: 3.5rem 4rem;
  display: flex; flex-direction: column; gap: 3.25rem;
}
a { color: var(--accent); text-underline-offset: 3px; text-decoration-thickness: 1px; }
a:hover { text-decoration-thickness: 2px; }
a:focus-visible, button:focus-visible { outline: 2px solid var(--accent); outline-offset: 3px; border-radius: 2px; }
header { display: grid; grid-template-columns: 1fr auto; gap: 2rem; align-items: end; }
header > div { min-width: 0; }
.eyebrow { font-family: var(--mono); font-size: .75rem; letter-spacing: .08em; text-transform: uppercase; color: var(--muted); margin: 0 0 .9rem; }
h1 { font-family: var(--display); font-weight: 400; font-size: clamp(2.4rem, 7vw, 3.6rem); line-height: 1.02; letter-spacing: -.015em; margin: 0; text-wrap: balance; }
.role { margin: 1rem 0 0; color: var(--muted); font-size: 1.05rem; max-width: 34rem; }
nav.links { display: flex; flex-wrap: wrap; gap: .5rem 1.4rem; font-size: .95rem; margin-top: 1.4rem; }
.avatar { width: 150px; height: 150px; object-fit: cover; border-radius: 50%; display: block; border: 1px solid var(--line); }
section { display: flex; flex-direction: column; gap: 1.1rem; }
h2 { font-family: var(--mono); font-weight: 400; font-size: .78rem; letter-spacing: .1em; text-transform: uppercase; color: var(--muted); margin: 0; padding-bottom: .6rem; border-bottom: 1px solid var(--line); }
.bio { gap: .9rem; }
.bio p { margin: 0; max-width: 40rem; }
.projects { list-style: none; margin: 0; padding: 0; display: flex; flex-direction: column; gap: 2.2rem; }
.proj { display: grid; grid-template-columns: 7.5rem 1fr; gap: 1.25rem; }
.proj > div { min-width: 0; }
.side { display: flex; flex-direction: column; gap: .35rem; padding-top: .35rem; }
.when { font-family: var(--mono); font-size: .8rem; color: var(--muted); font-variant-numeric: tabular-nums; }
.status { font-family: var(--mono); font-size: .72rem; display: inline-flex; align-items: center; gap: .4rem; color: var(--muted); }
.status::before { content: ""; width: .5rem; height: .5rem; border-radius: 50%; background: var(--ok); }
.status.wip::before { background: var(--wip); }
.proj h3 { font-family: var(--display); font-weight: 500; font-size: 1.45rem; line-height: 1.2; margin: 0 0 .15rem; text-wrap: balance; }
.where { font-size: .9rem; color: var(--muted); margin: 0 0 .55rem; }
.desc { margin: 0; }
.desc + .desc { margin-top: .6rem; }
.tags { display: flex; flex-wrap: wrap; gap: .4rem; list-style: none; padding: 0; margin: .8rem 0 0; }
.tags li { font-family: var(--mono); font-size: .72rem; border: 1px solid var(--line); background: var(--surface); padding: .15rem .5rem; border-radius: 3px; }
.more { display: inline-block; margin-top: .7rem; font-size: .92rem; }
.contact { display: flex; flex-wrap: wrap; align-items: center; gap: .6rem 1rem; }
.mail { font-family: var(--mono); font-size: .95rem; user-select: all; overflow-wrap: anywhere; }
.copy { font: inherit; font-size: .85rem; color: var(--fg); background: var(--surface); border: 1px solid var(--line); border-radius: 3px; padding: .25rem .7rem; cursor: pointer; }
.copy:hover { border-color: var(--accent); }
footer { font-size: .8rem; color: var(--muted); font-family: var(--mono); }
@media (max-width: 560px) {
  header { grid-template-columns: 1fr; }
  .avatar { width: 120px; height: 120px; order: -1; }
  .proj { grid-template-columns: 1fr; gap: .3rem; }
  .side { flex-direction: row; gap: 1rem; padding-top: 0; }
}
)"

# (La foto se carga desde persona$foto)

js_copiar <- HTML(r"(
document.getElementById('copy').addEventListener('click', function () {
  var btn = this, el = document.getElementById('mail');
  function done(){ btn.textContent = 'Copiado'; setTimeout(function(){ btn.textContent = 'Copiar correo'; }, 1600); }
  function fallback(){ var r = document.createRange(); r.selectNodeContents(el); var s = getSelection(); s.removeAllRanges(); s.addRange(r); }
  try { navigator.clipboard.writeText(el.textContent).then(done, fallback); } catch (e) { fallback(); }
});
)")

# ========================= CONSTRUCCIÓN ===========================

tarjeta_proyecto <- function(p) {
  en_curso <- identical(p$estado, "En curso")
  tags$li(class = "proj",
          tags$div(class = "side",
                   tags$span(class = "when", p$fecha),
                   tags$span(class = paste("status", if (en_curso) "wip"), p$estado)
          ),
          tags$div(
            tags$h3(p$titulo),
            tags$p(class = "where", p$contexto),
            lapply(p$descripcion, function(x) tags$p(class = "desc", HTML(x))),
            tags$ul(class = "tags", lapply(p$etiquetas, tags$li)),
            if (!is.null(p$enlace))
              tags$a(class = "more", href = p$enlace, target = "_blank", rel = "noopener",
                     paste0(p$enlace_texto, " →"))
          )
  )
}

cabeza <- tags$head(
  tags$meta(name = "viewport", content = "width=device-width, initial-scale=1, viewport-fit=cover"),
  tags$title(persona$nombre),
  tags$meta(name = "description", content = persona$rol),
  tags$link(rel = "preconnect", href = "https://fonts.googleapis.com"),
  tags$link(rel = "stylesheet",
            href = "https://fonts.googleapis.com/css2?family=Newsreader:opsz,wght@6..72,400;6..72,500&family=IBM+Plex+Sans:wght@400;500&family=IBM+Plex+Mono:wght@400&display=swap"),
  tags$style(HTML(css))
)

cuerpo <- tags$div(class = "wrap",
                   tags$header(
                     tags$div(
                       tags$h1(persona$nombre),
                       tags$p(class = "role", persona$rol),
                       tags$nav(class = "links", `aria-label` = "Perfiles",
                                lapply(enlaces, function(e)
                                  tags$a(href = e$url, target = "_blank", rel = "noopener", e$texto)))
                     ),
                     tags$img(class = "avatar", src = persona$foto, alt = paste("Foto de", persona$nombre))
                   ),
                   tags$section(class = "bio", `aria-labelledby` = "bio-h",
                                tags$h2(id = "bio-h", "Biografía"),
                                lapply(biografia, tags$p)
                   ),
                   tags$section(`aria-labelledby` = "proj-h",
                                tags$h2(id = "proj-h", "Proyectos"),
                                tags$ul(class = "projects", lapply(proyectos, tarjeta_proyecto))
                   ),
                   tags$section(`aria-labelledby` = "contact-h",
                                tags$h2(id = "contact-h", "Contacto"),
                                tags$div(class = "contact",
                                         tags$span(class = "mail", id = "mail", persona$email),
                                         tags$button(class = "copy", id = "copy", type = "button", "Copiar correo")
                                )
                   ),
                   tags$footer(paste("Última actualización ·", persona$actualizado)),
                   tags$script(js_copiar)
)

save_html(tagList(cabeza, cuerpo), file = archivo_salida,
          background = "var(--bg)", lang = "es")
message("Web generada en ", normalizePath(archivo_salida))