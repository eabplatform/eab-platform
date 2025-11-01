document.addEventListener('DOMContentLoaded', function() {
  // تحكم القائمة للموبايل
  const menuToggle = document.getElementById('menuToggle');
  const nav = document.querySelector('.nav');
  if(menuToggle) {
    menuToggle.addEventListener('click', function() {
      nav.classList.toggle('open');
      this.classList.toggle('active');
    });
  }

  // زر العودة للأعلى
  const topBtn = document.getElementById('backToTop');
  window.addEventListener('scroll', function() {
    if(!topBtn) return;
    if(window.scrollY > 350) {
      topBtn.style.opacity = '1';
      topBtn.style.visibility = 'visible';
    } else {
      topBtn.style.opacity = '0';
      topBtn.style.visibility = 'hidden';
    }
  });

  // إضافة زر العودة للأعلى ديناميكياً إذا لم يكن موجوداً
  if(!topBtn) {
    const backToTop = document.createElement('button');
    backToTop.id = 'backToTop';
    backToTop.innerHTML = '↑';
    backToTop.style.cssText = 'position:fixed;bottom:20px;left:20px;width:50px;height:50px;border-radius:50%;background:linear-gradient(45deg,var(--accent),var(--accent2));color:#04101a;border:none;font-size:20px;cursor:pointer;z-index:1000;opacity:0;visibility:hidden;transition:all 0.3s ease;';
    backToTop.addEventListener('click', () => window.scrollTo({top:0,behavior:'smooth'}));
    document.body.appendChild(backToTop);
  }

  // تأثيرات الظهور للعناصر
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
      if(entry.isIntersecting) {
        entry.target.classList.add('fade-in');
      }
    });
  }, observerOptions);

  // مراقبة العناصر لإضافة تأثيرات الظهور
  document.querySelectorAll('.card-box, .section-title').forEach(function(el) {
    observer.observe(el);
  });

  // إرسال النموذج لواتساب
  window.sendWhatsapp = function(name, service, details) {
    const msg = `📋 طلب مشروع جديد من الموقع\n\n👤 الاسم/المنشأة: ${name}\n🛠 الخدمة: ${service}\n📝 التفاصيل:\n${details}\n\n⏰ الوقت: ${new Date().toLocaleString('ar-SA')}`;
    // تم تغيير الرقم هنا إلى 967733071578
    const url = 'https://wa.me/967733071578?text=' + encodeURIComponent(msg);
    window.open(url, '_blank');
    
    // إظهار رسالة نجاح
    alert('✅ تم فتح واتساب مع رسالة جاهزة. فقط اضغط إرسال!');
    return false;
  };

  // إغلاق القائمة عند النقر على رابط
  document.querySelectorAll('.nav a').forEach(function(link) {
    link.addEventListener('click', function() {
      if(nav.classList.contains('open')) {
        nav.classList.remove('open');
        menuToggle.classList.remove('active');
      }
    });
  });
});
