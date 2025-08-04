window.addEventListener('message', function (event) {
    const zona = document.getElementById('safe-zone');
  
    if (event.data.action === 'showZone') {
      zona.innerText = event.data.label || "Zona";
      zona.style.backgroundColor = event.data.color || "gray";
      zona.classList.remove('hidden');
    } else if (event.data.action === 'hideZone') {
      zona.classList.add('hidden');
    }
  });
  