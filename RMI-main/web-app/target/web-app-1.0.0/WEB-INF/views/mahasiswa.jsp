<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monitoring Mahasiswa RMI</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background:
                radial-gradient(ellipse at 12% 0%, rgba(99, 102, 241, .10), transparent 34rem),
                #f8fafc;
        }

        .dashboard-card {
            box-shadow: 0 12px 30px -18px rgba(15, 23, 42, .24);
            transition: transform .2s ease, box-shadow .2s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 18px 34px -20px rgba(15, 23, 42, .3);
        }

        .table-row:last-child td { border-bottom: 0; }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                scroll-behavior: auto !important;
                transition-duration: .01ms !important;
                animation-duration: .01ms !important;
                animation-iteration-count: 1 !important;
            }
        }
    </style>
</head>
<body class="min-h-screen bg-slate-50 text-slate-800 antialiased">
<c:url var="dashboardUrl" value="/mahasiswa"/>
<c:url var="createUrl" value="/mahasiswa">
    <c:param name="form" value="create"/>
</c:url>

<header class="sticky top-0 z-20 border-b border-white/70 bg-white/90 shadow-sm backdrop-blur-xl">
    <nav class="mx-auto flex max-w-7xl items-center justify-between gap-4 px-4 py-4 sm:px-6 lg:px-8">
        <a href="${dashboardUrl}" class="flex items-center gap-3 text-slate-900 no-underline">
            <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br from-indigo-500 to-violet-700 text-white shadow-lg shadow-indigo-200">
                <i class="fa-solid fa-graduation-cap" aria-hidden="true"></i>
            </span>
            <span>
                <span class="block text-base font-bold tracking-tight sm:text-lg">Monitoring Mahasiswa RMI</span>
                <span class="hidden text-xs text-slate-500 sm:block">Dashboard administrator</span>
            </span>
        </a>
        <div class="flex items-center gap-3 sm:gap-5">
            <span class="hidden items-center gap-2 text-sm text-slate-600 sm:inline-flex">
                <span class="h-2 w-2 rounded-full bg-emerald-500" aria-hidden="true"></span>
                RMI port <strong class="font-semibold text-slate-800">${rmiRegistryPort}</strong>
            </span>
            <form method="post" action="${dashboardUrl}">
                <input type="hidden" name="action" value="logout">
                <input type="hidden" name="csrf" value="<c:out value='${csrfToken}'/>">
                <button type="submit" class="inline-flex items-center gap-2 rounded-lg border border-slate-200 px-3 py-2 text-sm font-semibold text-slate-600 transition hover:border-rose-200 hover:bg-rose-50 hover:text-rose-700">
                    <i class="fa-solid fa-arrow-right-from-bracket" aria-hidden="true"></i>
                    <span>Keluar</span>
                </button>
            </form>
        </div>
    </nav>
</header>

<main class="mx-auto max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
    <section class="relative mb-8 overflow-hidden rounded-3xl bg-gradient-to-br from-indigo-700 via-indigo-600 to-violet-700 px-6 py-7 text-white shadow-xl shadow-indigo-200/60 sm:px-8 sm:py-9">
        <div class="pointer-events-none absolute -right-10 -top-24 h-72 w-72 rounded-full border-[36px] border-white/5"></div>
        <div class="pointer-events-none absolute right-40 top-20 h-32 w-32 rounded-full bg-violet-400/20 blur-3xl"></div>
        <div class="relative flex flex-col justify-between gap-6 sm:flex-row sm:items-center">
            <div>
                <div class="mb-3 inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/10 px-3 py-1 text-xs font-semibold tracking-wide text-indigo-50">
                    <i class="fa-solid fa-chart-line" aria-hidden="true"></i>
                    DASHBOARD AKADEMIK
                </div>
                <h1 class="text-2xl font-bold tracking-tight sm:text-3xl">Data Mahasiswa</h1>
                <p class="mt-2 max-w-xl text-sm leading-6 text-indigo-100 sm:text-base">Pantau dan kelola data mahasiswa melalui satu dashboard yang terhubung langsung ke layanan Java RMI.</p>
            </div>
            <div class="flex shrink-0 items-center gap-3 self-start rounded-2xl border border-white/15 bg-white/10 px-4 py-3 backdrop-blur sm:self-auto">
                <span class="relative flex h-3 w-3">
                    <span class="absolute inline-flex h-full w-full animate-ping rounded-full bg-emerald-300 opacity-60"></span>
                    <span class="relative inline-flex h-3 w-3 rounded-full bg-emerald-300"></span>
                </span>
                <span>
                    <span class="block text-xs text-indigo-100">Koneksi server</span>
                    <span class="block text-sm font-semibold">Terhubung · port <c:out value="${rmiRegistryPort}"/></span>
                </span>
            </div>
        </div>
    </section>

    <section aria-label="Statistik sistem" class="mb-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
        <article class="dashboard-card rounded-2xl border border-indigo-100/80 bg-white p-5">
            <div class="flex items-start justify-between">
                <div>
                    <p class="text-sm font-medium text-slate-500">Total Mahasiswa</p>
                    <p class="mt-3 text-3xl font-bold tracking-tight text-slate-900"><c:out value="${totalMahasiswa}"/></p>
                    <p class="mt-1 text-xs text-slate-500"><i class="fa-solid fa-database mr-1 text-indigo-400" aria-hidden="true"></i>Data tersimpan di server</p>
                </div>
                <span class="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-indigo-50 to-indigo-100 text-lg text-indigo-600">
                    <i class="fa-solid fa-users" aria-hidden="true"></i>
                </span>
            </div>
        </article>
        <article class="dashboard-card rounded-2xl border border-emerald-100/80 bg-white p-5">
            <div class="flex items-start justify-between">
                <div>
                    <p class="text-sm font-medium text-slate-500">Status RMI Server</p>
                    <p class="mt-3 flex items-center gap-2 text-xl font-bold text-emerald-700">
                        <span class="h-2.5 w-2.5 rounded-full bg-emerald-500" aria-hidden="true"></span>
                        Connected
                    </p>
                    <p class="mt-1 text-xs text-slate-500"><i class="fa-solid fa-shield-heart mr-1 text-emerald-500" aria-hidden="true"></i>Registry port <c:out value="${rmiRegistryPort}"/> aktif</p>
                </div>
                <span class="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-emerald-50 to-emerald-100 text-lg text-emerald-600">
                    <i class="fa-solid fa-plug-circle-check" aria-hidden="true"></i>
                </span>
            </div>
        </article>
        <article class="dashboard-card rounded-2xl border border-sky-100/80 bg-white p-5 sm:col-span-2 xl:col-span-1">
            <div class="flex items-start justify-between">
                <div>
                    <p class="text-sm font-medium text-slate-500">Protokol</p>
                    <p class="mt-3 text-xl font-bold text-slate-900">JRMP / TCP</p>
                    <p class="mt-1 text-xs text-slate-500"><i class="fa-solid fa-bolt mr-1 text-sky-500" aria-hidden="true"></i>Komunikasi remote Java</p>
                </div>
                <span class="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-sky-50 to-sky-100 text-lg text-sky-600">
                    <i class="fa-solid fa-network-wired" aria-hidden="true"></i>
                </span>
            </div>
        </article>
    </section>

    <c:if test="${param.form eq 'create' or param.form eq 'edit'}">
        <section class="dashboard-card mb-6 rounded-2xl border border-slate-200 bg-white p-5 sm:p-6">
            <div class="mb-5">
                <h2 class="text-lg font-bold text-slate-900">
                    <c:choose>
                        <c:when test="${param.form eq 'edit'}">Ubah Mahasiswa</c:when>
                        <c:otherwise>Tambah Mahasiswa</c:otherwise>
                    </c:choose>
                </h2>
                <p class="mt-1 text-sm text-slate-500">Lengkapi informasi mahasiswa di bawah ini.</p>
            </div>
            <c:choose>
                <c:when test="${param.form eq 'edit' and empty selectedMahasiswa}">
                    <p class="rounded-lg bg-amber-50 px-4 py-3 text-sm text-amber-800">Data mahasiswa tidak ditemukan.</p>
                </c:when>
                <c:otherwise>
                    <form method="post" action="${dashboardUrl}" class="grid gap-4 sm:grid-cols-2">
                        <input type="hidden" name="action" value="${param.form eq 'edit' ? 'update' : 'create'}">
                        <input type="hidden" name="csrf" value="<c:out value='${csrfToken}'/>">
                        <label class="text-sm font-medium text-slate-700">
                            NIM
                            <input name="nim" maxlength="20" required
                                   value="<c:out value='${selectedMahasiswa.nim}'/>"
                                   <c:if test="${param.form eq 'edit'}">readonly</c:if>
                                   class="mt-1.5 block w-full rounded-lg border border-slate-300 px-3 py-2.5 font-normal outline-none transition placeholder:text-slate-400 focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100"
                                   placeholder="Contoh: 2023001">
                        </label>
                        <label class="text-sm font-medium text-slate-700">
                            Nama
                            <input name="nama" maxlength="100" required value="<c:out value='${selectedMahasiswa.nama}'/>"
                                   class="mt-1.5 block w-full rounded-lg border border-slate-300 px-3 py-2.5 font-normal outline-none transition focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100">
                        </label>
                        <label class="text-sm font-medium text-slate-700">
                            Program Studi
                            <input name="programStudi" maxlength="100" required value="<c:out value='${selectedMahasiswa.programStudi}'/>"
                                   class="mt-1.5 block w-full rounded-lg border border-slate-300 px-3 py-2.5 font-normal outline-none transition focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100">
                        </label>
                        <label class="text-sm font-medium text-slate-700">
                            Semester
                            <input type="number" name="semester" min="1" max="14" required
                                   value="<c:out value='${empty selectedMahasiswa ? 1 : selectedMahasiswa.semester}'/>"
                                   class="mt-1.5 block w-full rounded-lg border border-slate-300 px-3 py-2.5 font-normal outline-none transition focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100">
                        </label>
                        <label class="text-sm font-medium text-slate-700 sm:col-span-2">
                            Email
                            <input type="email" name="email" maxlength="150" required value="<c:out value='${selectedMahasiswa.email}'/>"
                                   class="mt-1.5 block w-full rounded-lg border border-slate-300 px-3 py-2.5 font-normal outline-none transition focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100">
                        </label>
                        <div class="flex gap-3 sm:col-span-2">
                            <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-indigo-600 px-4 py-2.5 text-sm font-semibold text-white transition hover:bg-indigo-700">
                                <i class="fa-solid fa-floppy-disk" aria-hidden="true"></i> Simpan
                            </button>
                            <a href="${dashboardUrl}" class="rounded-lg border border-slate-200 px-4 py-2.5 text-sm font-semibold text-slate-600 transition hover:bg-slate-50">Batal</a>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </section>
    </c:if>

    <c:if test="${not empty param.nim and empty param.form}">
        <section class="dashboard-card mb-6 rounded-2xl border border-slate-200 bg-white p-5">
            <h2 class="mb-4 text-lg font-bold text-slate-900">Detail Mahasiswa</h2>
            <c:choose>
                <c:when test="${empty selectedMahasiswa}">
                    <p class="text-sm text-rose-700">Data mahasiswa tidak ditemukan.</p>
                </c:when>
                <c:otherwise>
                    <dl class="grid gap-3 text-sm sm:grid-cols-2">
                        <div><dt class="text-slate-500">NIM</dt><dd class="mt-1 font-semibold"><c:out value="${selectedMahasiswa.nim}"/></dd></div>
                        <div><dt class="text-slate-500">Nama</dt><dd class="mt-1 font-semibold"><c:out value="${selectedMahasiswa.nama}"/></dd></div>
                        <div><dt class="text-slate-500">Program Studi</dt><dd class="mt-1 font-semibold"><c:out value="${selectedMahasiswa.programStudi}"/></dd></div>
                        <div><dt class="text-slate-500">Semester</dt><dd class="mt-1 font-semibold"><c:out value="${selectedMahasiswa.semester}"/></dd></div>
                        <div><dt class="text-slate-500">Email</dt><dd class="mt-1 font-semibold"><c:out value="${selectedMahasiswa.email}"/></dd></div>
                    </dl>
                </c:otherwise>
            </c:choose>
        </section>
    </c:if>

    <section class="overflow-hidden rounded-2xl border border-slate-200/80 bg-white shadow-xl shadow-slate-200/50">
        <div class="flex flex-col gap-4 border-b border-slate-100 p-5 sm:flex-row sm:items-center sm:justify-between sm:p-6">
            <div>
                <div class="flex items-center gap-2">
                    <span class="flex h-8 w-8 items-center justify-center rounded-lg bg-indigo-50 text-sm text-indigo-600"><i class="fa-solid fa-table-list" aria-hidden="true"></i></span>
                    <h2 class="text-lg font-bold text-slate-900">Daftar Mahasiswa</h2>
                </div>
                <p class="mt-2 text-sm text-slate-500">Cari, lihat, dan kelola informasi mahasiswa.</p>
            </div>
            <a href="${createUrl}" class="inline-flex items-center justify-center gap-2 rounded-xl bg-gradient-to-r from-emerald-600 to-teal-600 px-4 py-2.5 text-sm font-semibold text-white shadow-md shadow-emerald-200 transition hover:-translate-y-0.5 hover:from-emerald-700 hover:to-teal-700 hover:shadow-lg">
                <i class="fa-solid fa-plus" aria-hidden="true"></i> Tambah Mahasiswa
            </a>
        </div>

        <form method="get" action="${dashboardUrl}" class="flex flex-col gap-3 border-b border-slate-100 bg-slate-50/70 p-5 sm:flex-row sm:items-center sm:p-6">
            <label for="q" class="sr-only">Cari berdasarkan NIM</label>
            <div class="relative w-full sm:max-w-md">
                <i class="fa-solid fa-magnifying-glass pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400" aria-hidden="true"></i>
                <input id="q" name="q" value="<c:out value='${param.q}'/>" placeholder="Cari berdasarkan NIM..."
                       class="w-full rounded-lg border border-slate-300 bg-white py-2.5 pl-10 pr-3 text-sm outline-none transition placeholder:text-slate-400 focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100">
            </div>
            <button type="submit" class="rounded-lg bg-slate-800 px-4 py-2.5 text-sm font-semibold text-white transition hover:bg-slate-900">Cari</button>
            <a href="${dashboardUrl}" class="px-2 py-2 text-center text-sm font-semibold text-slate-500 transition hover:text-indigo-600">Reset</a>
        </form>

        <div class="overflow-x-auto">
            <table class="w-full min-w-[760px] text-left text-sm">
                <thead class="bg-slate-50/90 text-xs uppercase tracking-wider text-slate-500">
                <tr>
                    <th scope="col" class="px-6 py-3.5 font-semibold">NIM</th>
                    <th scope="col" class="px-6 py-3.5 font-semibold">Nama</th>
                    <th scope="col" class="px-6 py-3.5 font-semibold">Program Studi</th>
                    <th scope="col" class="px-6 py-3.5 font-semibold">Semester</th>
                    <th scope="col" class="px-6 py-3.5 font-semibold">Email</th>
                    <th scope="col" class="px-6 py-3.5 text-right font-semibold">Aksi</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                <c:forEach var="mahasiswa" items="${mahasiswaList}">
                    <c:url var="detailUrl" value="/mahasiswa">
                        <c:param name="nim" value="${mahasiswa.nim}"/>
                    </c:url>
                    <c:url var="editUrl" value="/mahasiswa">
                        <c:param name="form" value="edit"/>
                        <c:param name="nim" value="${mahasiswa.nim}"/>
                    </c:url>
                    <tr class="table-row transition hover:bg-indigo-50/40">
                        <td class="whitespace-nowrap px-6 py-4 font-semibold text-slate-700"><c:out value="${mahasiswa.nim}"/></td>
                        <td class="whitespace-nowrap px-6 py-4">
                            <a href="${detailUrl}" class="font-semibold text-indigo-700 hover:text-indigo-900"><c:out value="${mahasiswa.nama}"/></a>
                        </td>
                        <td class="whitespace-nowrap px-6 py-4">
                            <span class="inline-flex rounded-full bg-indigo-50 px-2.5 py-1 text-xs font-semibold text-indigo-700"><c:out value="${mahasiswa.programStudi}"/></span>
                        </td>
                        <td class="whitespace-nowrap px-6 py-4 text-slate-600"><c:out value="${mahasiswa.semester}"/></td>
                        <td class="whitespace-nowrap px-6 py-4 text-slate-600"><c:out value="${mahasiswa.email}"/></td>
                        <td class="whitespace-nowrap px-6 py-4">
                            <div class="flex justify-end gap-2">
                                <a href="${editUrl}" title="Ubah mahasiswa" aria-label="Ubah mahasiswa"
                                   class="inline-flex h-9 w-9 items-center justify-center rounded-lg border border-slate-200 text-slate-600 transition hover:border-indigo-200 hover:bg-indigo-50 hover:text-indigo-700">
                                    <i class="fa-solid fa-pen-to-square" aria-hidden="true"></i>
                                </a>
                                <form method="post" action="${dashboardUrl}" onsubmit="return confirm('Hapus data mahasiswa ini?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="csrf" value="<c:out value='${csrfToken}'/>">
                                    <input type="hidden" name="nim" value="<c:out value='${mahasiswa.nim}'/>">
                                    <button type="submit" title="Hapus mahasiswa" aria-label="Hapus mahasiswa"
                                            class="inline-flex h-9 w-9 items-center justify-center rounded-lg border border-slate-200 text-slate-600 transition hover:border-rose-200 hover:bg-rose-50 hover:text-rose-700">
                                        <i class="fa-solid fa-trash-can" aria-hidden="true"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty mahasiswaList}">
                    <tr>
                        <td colspan="6" class="px-6 py-14 text-center">
                            <span class="mx-auto mb-3 flex h-12 w-12 items-center justify-center rounded-full bg-slate-100 text-slate-400">
                                <i class="fa-solid fa-user-group" aria-hidden="true"></i>
                            </span>
                            <p class="font-semibold text-slate-700">Tidak ada data mahasiswa</p>
                            <p class="mt-1 text-sm text-slate-500">Coba ubah kata kunci pencarian atau tambahkan data baru.</p>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
    <footer class="py-6 text-center text-xs text-slate-400">Monitoring Mahasiswa RMI · JRMP/TCP</footer>
</main>
</body>
</html>
