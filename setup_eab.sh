#!/bin/bash
set -e
# إنشاء بنية المشروع
rm -rf EAB-Platform
mkdir -p EAB-Platform/{css,js,assets/img}
cd EAB-Platform

# ---------- logo (SVG) ----------
cat > assets/img/logo.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="180" height="60" viewBox="0 0 360 120">
  <defs>
    <linearGradient id="g" x1="0" x2="1">
      <stop offset="0" stop-color="#00FF88"/>
      <stop offset="1" stop-color="#00B3FF"/>
    </linearGradient>
  </defs>
  <rect width="100%" height="100%" fill="#0A0F14" rx="8"/>
  <text x="30" y="75" font-family="Orbitron, Arial, sans-serif" font-size="44" fill="url(#g)">
    &lt;EAB /&gt;
  </text>
  <text x="250" y="78" font-family="Cairo, Arial, sans-serif" font-size="22" fill="#98A2B3">PLATFORM</text>
</svg>
EOF

# ---------- CSS ----------
cat > css/style.css << 'EOF'
:root{
  --bg:#0A0F14;
  --card:#0F1720;
  --text:#C9D1D9;
  --muted:#98A2B3;
  --accent:#00FF88; /* أخضر فسفوري */
  --accent2:#00B3FF; /* أزرق نيوني ثانوي */
  --glass: rgba(255,255,255,0.03);
  --glass-2: rgba(0,255,136,0.06);
  --radius:12px;
  --shadow: 0 8px 30px rgba(0,0,0,0.6);
  font-family: 'Cairo', 'Orbitron', sans-serif;
}

*{box-sizing:border-box;margin:0;padding:0}
html,body{height:100%}
body{
  background: linear-gradient(180deg,var(--bg) 0%, #04060a 100%);
  color:var(--text);
  direction:rtl;
  -webkit-font-smoothing:antialiased;
  line-height:1.6;
}

/* container */
.container{width:92%;max-width:1200px;margin:0 auto;padding:24px}

/* navbar/header */
.header{
  position:fixed;left:0;right:0;top:0;z-index:999;
  background: linear-gradient(90deg, rgba(10,15,20,0.75), rgba(10,15,20,0.55));
  backdrop-filter: blur(6px);
  border-bottom:1px solid rgba(255,255,255,0.03);
}
.header .bar{display:flex;align-items:center;justify-content:space-between;padding:14px 0}
.logo{display:flex;align-items:center;gap:12px}
.logo img{width:46px;height:46px;border-radius:8px;background:var(--glass-2);padding:4px}
.logo h1{font-size:1.1rem;letter-spacing:1px;color:var(--text)}
.nav{display:flex;gap:18px;align-items:center}
.nav a{color:var(--muted);text-decoration:none;padding:8px 12px;border-radius:8px;font-weight:600}
.nav a:hover, .nav a.active{color:var(--accent);background:rgba(0,255,136,0.04)}

/* menu toggle mobile */
.menu-toggle{display:none;cursor:pointer}
.menu-toggle span{display:block;width:26px;height:3px;background:var(--accent);margin:4px 0;border-radius:3px}

/* hero */
.hero{height:92vh;display:flex;align-items:center;justify-content:center;text-align:center;padding:120px 20px 40px}
.hero .card{background:linear-gradient(180deg,var(--card), #0b1220);padding:40px;border-radius:18px;box-shadow:var(--shadow);max-width:900px;width:100%;border:1px solid rgba(0,255,136,0.06)}
.hero h2{font-size:2.4rem;margin-bottom:12px;color:var(--text)}
.hero h2 span{color:var(--accent);text-shadow:0 6px 18px rgba(0,255,136,0.06)}
.hero p{color:var(--muted);margin-bottom:22px}

/* buttons */
.btn{display:inline-block;padding:12px 20px;border-radius:10px;font-weight:700;text-decoration:none;transition:transform .18s}
.btn-primary{background:linear-gradient(90deg,var(--accent),var(--accent2));color:#04101a}
.btn-ghost{border:1px solid rgba(255,255,255,0.06);color:var(--text);background:transparent}

/* sections */
section{padding:80px 0}
.section-title{font-size:1.8rem;color:var(--accent);margin-bottom:18px}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:20px}
.card-box{background:linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));padding:22px;border-radius:14px;border:1px solid rgba(255,255,255,0.03)}
.card-box h3{color:var(--text);margin-bottom:10px}
.card-box p{color:var(--muted);font-size:0.95rem}

/* contact form */
.contact-form .input, .contact-form textarea, .contact-form select{
  width:100%;padding:12px;border-radius:10px;border:1px solid rgba(255,255,255,0.04);background:#071016;color:var(--text);margin-bottom:12px
}

/* footer */
footer{background:#05060a;padding:40px 0;border-top:1px solid rgba(255,255,255,0.03)}
.footer .muted{color:var(--muted);font-size:0.94rem}

/* small screens */
@media (max-width:900px){
  .nav{display:none}
  .menu-toggle{display:block}
  .hero{padding-top:140px}
}
EOF

# ---------- JS ----------
cat > js/main.js << 'EOF'
/* Basic interactivity: menu toggle, dark mode, back-to-top */
document.addEventListener('DOMContentLoaded',function(){
  // Menu toggle
  const menuToggle = document.getElementById('menuToggle');
  const nav = document.querySelector('.nav');
  if(menuToggle){
    menuToggle.addEventListener('click',()=> nav.classList.toggle('open'));
  }

  // Back to top
  const topBtn = document.getElementById('backToTop');
  window.addEventListener('scroll',()=>{
    if(!topBtn) return;
    topBtn.style.display = window.scrollY > 350 ? 'block' : 'none';
  });
  if(topBtn) topBtn.addEventListener('click',()=> window.scrollTo({top:0,behavior:'smooth'}));

  // Simple persisted theme (light/dark) - though design is dark by default
  const themeBtn = document.getElementById('themeToggle');
  const body = document.body;
  const saved = localStorage.getItem('eab-theme');
  if(saved === 'light') body.classList.add('light-mode');
  if(themeBtn) themeBtn.addEventListener('click',()=>{
    body.classList.toggle('light-mode');
    localStorage.setItem('eab-theme', body.classList.contains('light-mode') ? 'light' : 'dark');
  });

  // Form -> open whatsapp
  window.sendWhatsapp = function(name,service,details){
    const msg = `طلب مشروع جديد\nالاسم/المنشأة: ${name}\nالخدمة: ${service}\nالتفاصيل:\n${details}`;
    const url = 'https://wa.me/966544158661?text=' + encodeURIComponent(msg);
    window.open(url,'_blank');
    return false;
  };
});
EOF

# ---------- index.html ----------
cat > index.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>منصة EAB-Platform — خدمات طلابية متكاملة</title>
<meta name="description" content="منصة EAB لخدمات المشاريع والبرمجة والماتلاب — حلول احترافية للطلاب.">
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
  <header class="header">
    <div class="container bar">
      <div class="logo">
        <img src="assets/img/logo.svg" alt="EAB Logo">
        <h1>EAB-Platform</h1>
      </div>
      <nav class="nav">
        <a href="index.html" class="active">الرئيسية</a>
        <a href="services.html">الخدمات</a>
        <a href="projects.html">المشاريع</a>
        <a href="team.html">فريق العمل</a>
        <a href="blog.html">المدونة</a>
        <a href="contact.html">تواصل</a>
      </nav>
      <div class="menu-toggle" id="menuToggle" aria-label="قائمة">
        <span></span><span></span><span></span>
      </div>
    </div>
  </header>

  <main>
    <section class="hero">
      <div class="card container">
        <h2>حلول طلابية احترافية في البرمجة، الماتلاب، والمشاريع</h2>
        <p>نقدّم خدمات متكاملة لإنهاء مشاريع التخرج، واجبات الماتلاب، ومشاريع البرمجة بمستوى احترافي مع دعم فني شامل.</p>
        <div style="margin-top:18px;">
          <a href="services.html" class="btn btn-primary">استعرض خدماتنا</a>
          <a href="contact.html" class="btn btn-ghost">اطلب الآن</a>
        </div>
      </div>
    </section>

    <section>
      <div class="container">
        <h3 class="section-title">لماذا تختار EAB؟</h3>
        <div class="grid">
          <div class="card-box">
            <h3>دقة أكاديمية</h3>
            <p>مراجع علمية ومخرجات قابلة للتسليم مع توثيق مفصّل يضمن لك أعلى الدرجات.</p>
          </div>
          <div class="card-box">
            <h3>خبراء تخصصيون</h3>
            <p>فريق من المهندسين والمطورين ذوي خبرة في الماتلاب، الذكاء الاصطناعي والتحكم.</p>
          </div>
          <div class="card-box">
            <h3>دعم ما بعد التسليم</h3>
            <p>نقدّم متابعة وتوضيحات بعد التسليم حتى تتأكد من الفهم الكامل للمشروع.</p>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="container">
        <h3 class="section-title">نماذج مشاريع</h3>
        <div class="grid">
          <div class="card-box">
            <h3>نظام تحكم بالمحاكاة (MATLAB)</h3>
            <p>تصميم وتحليل نظام تحكم مع محاكاة كاملة وتقارير باللغة العربية والإنجليزية.</p>
          </div>
          <div class="card-box">
            <h3>مشروع برمجي متكامل</h3>
            <p>تطبيق ويب أو برنامج سطح مكتب مع توثيق كامل وقاعدة بيانات حسب المتطلبات.</p>
          </div>
          <div class="card-box">
            <h3>بحث علمي</h3>
            <p>مساعدة في صياغة البحث، مراجعة الأدبيات، وتحليل البيانات وريبوتر للجداول.</p>
          </div>
        </div>
      </div>
    </section>

    <section id="cta">
      <div class="container card-box" style="text-align:center">
        <h3>هل تريد بدء مشروعك الآن؟</h3>
        <p class="muted">املأ نموذج التواصل أو تواصل مباشرة عبر واتساب للحصول على عرض سعر ومخطط زمني.</p>
        <div style="margin-top:12px">
          <a href="contact.html" class="btn btn-primary">ابدأ الآن</a>
        </div>
      </div>
    </section>
  </main>

  <footer>
    <div class="container">
      <div style="display:flex;gap:20px;flex-wrap:wrap;justify-content:space-between;align-items:center">
        <div>
          <strong style="color:var(--accent)">EAB-Platform</strong>
          <p class="muted">خدمات طلابية متكاملة — مشاريع، برمجة، وماتلاب.</p>
        </div>
        <div class="muted">واتساب: 00966544158661 &nbsp;|&nbsp; البريد: eabplatform@gmail.com</div>
      </div>
    </div>
  </footer>

<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- services.html ----------
cat > services.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>الخدمات — EAB-Platform</title>
<meta name="description" content="قائمة خدمات منصة EAB: مشاريع تخرج، ماتلاب، برمجة، تحليل بيانات، واستشارات أكاديمية.">
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="header">
  <div class="container bar">
    <div class="logo"><img src="assets/img/logo.svg" alt="logo"><h1>EAB-Platform</h1></div>
    <nav class="nav">
      <a href="index.html">الرئيسية</a>
      <a href="services.html" class="active">الخدمات</a>
      <a href="projects.html">المشاريع</a>
      <a href="team.html">فريق العمل</a>
      <a href="contact.html">تواصل</a>
    </nav>
    <div class="menu-toggle" id="menuToggle"><span></span><span></span><span></span></div>
  </div>
</header>

<main style="padding-top:120px">
  <section>
    <div class="container">
      <h2 class="section-title">خدماتنا التفصيلية</h2>
      <div class="grid">
        <div class="card-box">
          <h3>مشاريع تخرج متكاملة</h3>
          <p>حلول جاهزة للتسليم تشمل الكود، المحاكاة، التقارير، والعرض التقديمي.</p>
        </div>
        <div class="card-box">
          <h3>دعم Matlab / Simulink</h3>
          <p>أنظمة تحكم، تحليل سيغنال، ومحاكاة متقدمة مع تفسير النتائج خطوة بخطوة.</p>
        </div>
        <div class="card-box">
          <h3>تطوير برمجيات</h3>
          <p>تطبيقات ويب وبرامج سطح مكتب، تعليمات تثبيت، ودعم تشغيل بنظام الإنتاج.</p>
        </div>
        <div class="card-box">
          <h3>تحليل بيانات</h3>
          <p>تنظيف بيانات، تحليل إحصائي، واستخراج نتائج قابلة للتقديم في بحثك.</p>
        </div>
        <div class="card-box">
          <h3>مراجعة أكاديمية</h3>
          <p>مراجعة لغوية وتقنية للأبحاث والتقارير قبل التسليم والرفع للمؤسسات.</p>
        </div>
        <div class="card-box">
          <h3>دورات مخصصة</h3>
          <p>جلسات تدريبية مركزة في Matlab، Python، والتحكم، مصمّمة لطلبة الجامعة.</p>
        </div>
      </div>
    </div>
  </section>
</main>

<footer>
  <div class="container">
    <div style="display:flex;justify-content:space-between;align-items:center">
      <div style="color:var(--accent)">EAB-Platform</div>
      <div class="muted">واتساب: 00966544158661</div>
    </div>
  </div>
</footer>

<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- projects.html ----------
cat > projects.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>المشاريع — EAB-Platform</title>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css"></head>
<body>
<header class="header">
  <div class="container bar">
    <div class="logo"><img src="assets/img/logo.svg" alt="logo"><h1>EAB-Platform</h1></div>
    <nav class="nav"><a href="index.html">الرئيسية</a><a href="services.html">الخدمات</a><a href="projects.html" class="active">المشاريع</a><a href="team.html">فريق العمل</a><a href="contact.html">تواصل</a></nav>
    <div class="menu-toggle" id="menuToggle"><span></span><span></span><span></span></div>
  </div>
</header>

<main style="padding-top:120px">
  <section>
    <div class="container">
      <h2 class="section-title">نماذج من أعمالنا</h2>
      <div class="grid">
        <div class="card-box">
          <h3>نظام تحكم روبوتي</h3><p>نماذج محاكاة وإجراءات تحكم مع وثائق وشرح للاختبارات.</p>
        </div>
        <div class="card-box">
          <h3>مشروع تحليل بيانات</h3><p>تنقيب بيانات لقياسات مختبرية وتقارير مرئية جاهزة.</p>
        </div>
        <div class="card-box">
          <h3>تطبيق ويب تعليمي</h3><p>منصة بسيطة للتدريب على البرمجة ومشاركة الحلول بين الطلبة.</p>
        </div>
      </div>
    </div>
  </section>
</main>

<footer>
  <div class="container"><div style="display:flex;justify-content:space-between;align-items:center"><div style="color:var(--accent)">EAB-Platform</div><div class="muted">واتساب: 00966544158661</div></div></div>
</footer>
<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- team.html ----------
cat > team.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>فريق العمل — EAB-Platform</title>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css"></head>
<body>
<header class="header">
  <div class="container bar"><div class="logo"><img src="assets/img/logo.svg" alt="logo"><h1>EAB-Platform</h1></div>
  <nav class="nav"><a href="index.html">الرئيسية</a><a href="services.html">الخدمات</a><a href="projects.html">المشاريع</a><a href="team.html" class="active">فريق العمل</a><a href="contact.html">تواصل</a></nav>
  <div class="menu-toggle" id="menuToggle"><span></span><span></span><span></span></div></div>
</header>

<main style="padding-top:120px">
  <section>
    <div class="container">
      <h2 class="section-title">فريقنا</h2>
      <div class="grid">
        <div class="card-box"><h3>م. أحمد — مهندس نظم</h3><p>تصميم أنظمة تحكم ومحاكاة Matlab.</p></div>
        <div class="card-box"><h3>م. سارة — مطورة برمجيات</h3><p>تطوير تطبيقات ويب وقواعد بيانات.</p></div>
        <div class="card-box"><h3>د. خالد — مشرف أكاديمي</h3><p>دعم بصياغة الأبحاث ومراجعتها علمياً.</p></div>
      </div>
    </div>
  </section>
</main>

<footer><div class="container"><div style="display:flex;justify-content:space-between;align-items:center"><div style="color:var(--accent)">EAB-Platform</div><div class="muted">واتساب: 00966544158661</div></div></div></footer>
<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- blog.html ----------
cat > blog.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>المدونة — EAB-Platform</title>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css"></head>
<body>
<header class="header"><div class="container bar"><div class="logo"><img src="assets/img/logo.svg" alt="logo"><h1>EAB-Platform</h1></div><nav class="nav"><a href="index.html">الرئيسية</a><a href="services.html">الخدمات</a><a href="blog.html" class="active">المدونة</a><a href="contact.html">تواصل</a></nav><div class="menu-toggle" id="menuToggle"><span></span><span></span><span></span></div></div></header>

<main style="padding-top:120px">
  <section>
    <div class="container">
      <h2 class="section-title">مقالات ونشرات</h2>
      <div class="grid">
        <div class="card-box"><h3>دليل Matlab للطلبة</h3><p>مقالة مبسطة عن أفضل الممارسات في المشاريع العملية.</p></div>
        <div class="card-box"><h3>تنظيف وتحليل البيانات</h3><p>خطوات عملية لتحضير بياناتك للتحليل الأكاديمي.</p></div>
      </div>
    </div>
  </section>
</main>

<footer><div class="container"><div style="display:flex;justify-content:space-between;align-items:center"><div style="color:var(--accent)">EAB-Platform</div><div class="muted">واتساب: 00966544158661</div></div></div></footer>
<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- contact.html ----------
cat > contact.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>تواصل معنا — EAB-Platform</title>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css"></head>
<body>
<header class="header"><div class="container bar"><div class="logo"><img src="assets/img/logo.svg" alt="logo"><h1>EAB-Platform</h1></div><nav class="nav"><a href="index.html">الرئيسية</a><a href="services.html">الخدمات</a><a href="contact.html" class="active">تواصل</a></nav><div class="menu-toggle" id="menuToggle"><span></span><span></span><span></span></div></div></header>

<main style="padding-top:120px">
  <section>
    <div class="container">
      <h2 class="section-title">تواصل معنا</h2>
      <div class="grid">
        <div class="card-box">
          <h3>مراسلة سريعة عبر واتساب</h3>
          <p>أسرع وسيلة للتواصل: اضغط لإرسال رسالة مهيأة.</p>
          <a href="https://wa.me/966544158661" class="btn btn-primary" target="_blank">إرسال رسالة</a>
        </div>
        <div class="card-box">
          <h3>أرسل طلب مشروع</h3>
          <form class="contact-form" onsubmit="return handleSubmit(this);">
            <input class="input" id="who" placeholder="الاسم/المنشأة" required>
            <select id="svc" class="input" required>
              <option value="مشروع تخرج">مشروع تخرج</option>
              <option value="دعم Matlab">دعم Matlab</option>
              <option value="برمجة">برمجة</option>
              <option value="مراجعة بحث">مراجعة بحث</option>
            </select>
            <textarea id="det" rows="5" placeholder="تفاصيل الطلب..." required></textarea>
            <button class="btn btn-primary" type="submit">إرسال عبر واتساب</button>
          </form>
          <script>
            function handleSubmit(form){
              const n = document.getElementById('who').value;
              const s = document.getElementById('svc').value;
              const d = document.getElementById('det').value;
              return sendWhatsapp(n,s,d);
            }
          </script>
        </div>
      </div>
    </div>
  </section>
</main>

<footer><div class="container"><div style="display:flex;justify-content:space-between;align-items:center"><div style="color:var(--accent)">EAB-Platform</div><div class="muted">واتساب: 00966544158661</div></div></div></footer>
<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- privacy.html ----------
cat > privacy.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>سياسة الخصوصية — EAB-Platform</title>
<link rel="stylesheet" href="css/style.css"></head>
<body>
<header class="header"><div class="container bar"><div class="logo"><img src="assets/img/logo.svg" alt="logo"><h1>EAB-Platform</h1></div></div></header>
<main style="padding-top:120px">
  <div class="container card-box">
    <h2 class="section-title">سياسة الخصوصية</h2>
    <p class="muted">نحترم خصوصيتك. لا نشارك بياناتك مع أطراف ثالثة ونستخدم المعلومات فقط لتحسين الخدمات والتواصل بشأن طلبك.</p>
  </div>
</main>
<footer><div class="container"><div style="display:flex;justify-content:space-between;align-items:center"><div style="color:var(--accent)">EAB-Platform</div></div></div></footer>
<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- terms.html ----------
cat > terms.html << 'EOF'
<!doctype html>
<html lang="ar" dir="rtl">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>شروط الاستخدام — EAB-Platform</title>
<link rel="stylesheet" href="css/style.css"></head>
<body>
<header class="header"><div class="container bar"><div class="logo"><img src="assets/img/logo.svg" alt="logo"><h1>EAB-Platform</h1></div></div></header>
<main style="padding-top:120px">
  <div class="container card-box">
    <h2 class="section-title">شروط الاستخدام</h2>
    <p class="muted">باستخدامك للموقع توافق على شروطنا التي تهدف لحماية حقوق جميع الأطراف وتوضيح آليات العمل والدفع والتسليم.</p>
  </div>
</main>
<footer><div class="container"><div style="display:flex;justify-content:space-between;align-items:center"><div style="color:var(--accent)">EAB-Platform</div></div></div></footer>
<script src="js/main.js" defer></script>
</body>
</html>
EOF

# ---------- final touches ----------
echo "All files created in: $(pwd)"
echo "To serve locally: run 'php -S 0.0.0.0:8080' or 'python3 -m http.server 8080' then open http://localhost:8080"
