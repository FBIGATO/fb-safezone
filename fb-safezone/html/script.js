window.addEventListener('message', function (event) {
  const zona = document.getElementById('safe-zone');
  const icono = document.getElementById('zone-icon');
  const texto = document.getElementById('zone-text');

  if (event.data.action === 'showZone') {
      texto.innerText = event.data.label || "Zona";
      zona.style.backgroundColor = event.data.color || "gray";
      
      // Cambiar ícono si viene en el mensaje
      if (event.data.icon) {
          icono.className = event.data.icon;
      }

      zona.classList.remove('hidden');
  } else if (event.data.action === 'hideZone') {
      zona.classList.add('hidden');
  }
});
