// Menambahkan log sederhana ke konsol browser untuk estetika developer
console.log(
    "%c System Online %c Portfolio Web Server aktif ",
    "background: #1f6feb; color: #fff; padding: 2px 6px; font-weight: bold; border-radius: 4px 0 0 4px;",
    "background: #21262d; color: #c9d1d9; padding: 2px 6px; border-radius: 0 4px 4px 0;"
);

// Efek interaksi klik tombol kontak atau navigasi halus tambahan jika diperlukan
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});