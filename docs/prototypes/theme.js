/* ==========================================================================
   CARDPILOT THEME MANAGER & INTERACTIVE UTILITIES
   ========================================================================== */

(function () {
  // Theme Manager
  const currentTheme = localStorage.getItem('theme') || 'dark';
  document.documentElement.setAttribute('data-theme', currentTheme);

  window.toggleTheme = function () {
    const activeTheme = document.documentElement.getAttribute('data-theme');
    const newTheme = activeTheme === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
  };

  // Scroll Spy Observer for Sidebar navigation
  document.addEventListener('DOMContentLoaded', () => {
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('.sidebar a');

    if (sections.length > 0 && navLinks.length > 0) {
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            navLinks.forEach(link => link.classList.remove('active'));
            const targetLink = document.querySelector(`.sidebar a[href="#${entry.target.id}"]`);
            if (targetLink) targetLink.classList.add('active');
          }
        });
      }, { threshold: 0.15, rootMargin: '-60px 0px -50% 0px' });

      sections.forEach(sec => observer.observe(sec));
    }
  });

})();
