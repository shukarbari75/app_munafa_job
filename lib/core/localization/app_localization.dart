import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLocalization {
  final Locale locale;
  AppLocalization(this.locale);

  static  AppLocalization? of(BuildContext  context){
   return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static  LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocale = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
    Locale('ar', 'SA'),
    Locale('hi', 'IN'),
  ];

  static bool isRTL(String languageCode) {
    return languageCode == 'ur' || languageCode == 'ar';
  }

  static final Map<String, Map<String,  String>>  localizationValues = {
    'en' : {
      // General & App
      'app_name': 'Munafa',
      'app_subtitle': 'Business & Profit Tracker',
      'loading': 'Loading...',
      'skip': 'Skip',
      'next': 'Next',
      'get_started': 'Get Started',
      'back': 'Back',
      'select_language': 'Select Language',
      'choose_preferred_language': 'Choose your preferred language to continue',
      'confirm': 'Confirm',

      // Languages
      'lang_en': 'English',
      'lang_ur': 'اردو (Urdu)',
      'lang_ar': 'العربية (Arabic)',
      'lang_hi': 'हिन्दी (Hindi)',

      // Splash
      'splash_tagline': 'Invest  •  Track  •  Grow',
      'splash_subtagline': 'Smart Financial Management for Growing Businesses',

      // Onboarding Slide 1
      'onboard_badge_1': 'SMART TRACKING',
      'onboard_title_1': 'Track Income & Expenses Seamlessly',
      'onboard_desc_1': 'Record daily transactions, sales receipts, and business cashflows in seconds with crystal clear reports.',
      'onboard_stat_1_val': '100%',
      'onboard_stat_1_lbl': 'Accurate Tracking',
      'onboard_stat_2_val': 'Instant',
      'onboard_stat_2_lbl': 'Cashflow Sync',

      // Onboarding Slide 2
      'onboard_badge_2': 'PROFIT ANALYTICS',
      'onboard_title_2': 'Real-Time Profit & Margin Insights',
      'onboard_desc_2': 'Understand your true margins, top-selling items, and seasonal profit trends through intuitive visual dashboards.',
      'onboard_stat_1_val_2': '+35%',
      'onboard_stat_1_lbl_2': 'Avg. Profit Gain',
      'onboard_stat_2_val_2': '24/7',
      'onboard_stat_2_lbl_2': 'Live Insights',

      // Onboarding Slide 3
      'onboard_badge_3': 'BUSINESS GROWTH',
      'onboard_title_3': 'Scale Your Business With Confidence',
      'onboard_desc_3': 'Empower your enterprise with automated financial summaries, PDF exports, and multi-currency ledger records.',
      'onboard_stat_1_val_3': 'Encrypted',
      'onboard_stat_1_lbl_3': 'Cloud Security',
      'onboard_stat_2_val_3': '1-Click',
      'onboard_stat_2_lbl_3': 'Export Reports',
    },

      'ur': {
        // General & App
        'app_name': 'منافع',
        'app_subtitle': 'کاروبار اور منافع کا حساب',
        'loading': 'لوڈ ہو رہا ہے...',
        'skip': 'چھوڑیں',
        'next': 'اگلا',
        'get_started': 'شروع کریں',
        'back': 'پیچھے',
        'select_language': 'زبان منتخب کریں',
        'choose_preferred_language': 'جاری رکھنے کے لیے اپنی پسندیدہ زبان منتخب کریں',
        'confirm': 'تصدیق کریں',

        // Languages
        'lang_en': 'English (انگریزی)',
        'lang_ur': 'اردو',
        'lang_ar': 'العربية (عربی)',
        'lang_hi': 'हिन्दी (ہندی)',

        // Splash
        'splash_tagline': 'سرمایہ کاری  •  حساب  •  ترقی',
        'splash_subtagline': 'کاروبار کے لیے آسان اور محفوظ مالیاتی نظام',

        // Onboarding Slide 1
        'onboard_badge_1': 'اسمارٹ حساب کتاب',
        'onboard_title_1': 'آمدن اور اخراجات کا مکمل ریکارڈ',
        'onboard_desc_1': 'روزانہ کے مالی لین دین، بل اور نقد رقم کا ریکارڈ سیکنڈوں میں محفوظ کریں اور شفاف رپورٹس حاصل کریں۔',
        'onboard_stat_1_val': '100%',
        'onboard_stat_1_lbl': 'درست ریکارڈ',
        'onboard_stat_2_val': 'فوری',
        'onboard_stat_2_lbl': 'نقد ہم آہنگی',

        // Onboarding Slide 2
        'onboard_badge_2': 'منافع کا تجزیہ',
        'onboard_title_2': 'حقیقی منافع اور مارجن کی مکمل معلومات',
        'onboard_desc_2': 'اپنے منافع کے تناسب اور بہترین فروخت والی اشیاء کو جدید اور خوبصورت چارٹس کے ذریعے سمجھیں۔',
        'onboard_stat_1_val_2': '+35%',
        'onboard_stat_1_lbl_2': 'اوسط اضافہ',
        'onboard_stat_2_val_2': '24/7',
        'onboard_stat_2_lbl_2': 'لائیو رپورٹس',

        // Onboarding Slide 3
        'onboard_badge_3': 'کاروباری وسعت',
        'onboard_title_3': 'اپنے کاروبار کو پراعتماد طریقے سے وسعت دیں',
        'onboard_desc_3': 'خودکار مالیاتی سمریز، پی ڈی ایف ایکسپورٹ اور محفوظ کھاتوں کے ذریعے اپنے کاروبار کو مضبوط بنائیں۔',
        'onboard_stat_1_val_3': 'محفوظ',
        'onboard_stat_1_lbl_3': 'ڈیٹا سیکیورٹی',
        'onboard_stat_2_val_3': 'ایک کلک',
        'onboard_stat_2_lbl_3': 'رپورٹ ڈاؤن لوڈ',
      },

    'ar': {
      // General & App
      'app_name': 'منافع',
      'app_subtitle': 'تتبع الأعمال والأرباح',
      'loading': 'جارٍ التحميل...',
      'skip': 'تخطي',
      'next': 'التالي',
      'get_started': 'ابدأ الآن',
      'back': 'رجوع',
      'select_language': 'اختر اللغة',
      'choose_preferred_language': 'اختر لغتك المفضلة للمتابعة',
      'confirm': 'تأكيد',

      // Languages
      'lang_en': 'English (الإنجليزية)',
      'lang_ur': 'الأردية (Urdu)',
      'lang_ar': 'العربية',
      'lang_hi': 'الهندية (Hindi)',

      // Splash
      'splash_tagline': 'استثمر  •  تتبّع  •  تنمو',
      'splash_subtagline': 'الإدارة المالية الذكية للأنشطة التجارية المتنامية',

      // Onboarding Slide 1
      'onboard_badge_1': 'تتبع ذكي',
      'onboard_title_1': 'تتبع الدخل والمصروفات بسهولة',
      'onboard_desc_1': 'سجل المعاملات اليومية وإيصالات المبيعات والتدفقات النقدية في ثوانٍ مع تقارير واضحة وشاملة.',
      'onboard_stat_1_val': '100%',
      'onboard_stat_1_lbl': 'دقة السجلات',
      'onboard_stat_2_val': 'فوري',
      'onboard_stat_2_lbl': 'مزامنة نقدية',

      // Onboarding Slide 2
      'onboard_badge_2': 'تحليلات الأرباح',
      'onboard_title_2': 'رؤى فورية للأرباح وهوامش الربح',
      'onboard_desc_2': 'تعرف على هوامش ربحك الحقيقية والمنتجات الأكثر مبيعاً واتجاهات الأرباح عبر لوحات تحكم بصرية مميزة.',
      'onboard_stat_1_val_2': '+35%',
      'onboard_stat_1_lbl_2': 'متوسط النمو',
      'onboard_stat_2_val_2': '24/7',
      'onboard_stat_2_lbl_2': 'تقارير حية',

      // Onboarding Slide 3
      'onboard_badge_3': 'نمو الأعمال',
      'onboard_title_3': 'طور أعمالك وحقق أهدافك بثقة',
      'onboard_desc_3': 'عزز أعمالك بتقارير مالية مؤتمتة، تصدير ملفات PDF، وإدارة شاملة لدفاتر الحسابات متعددة العملات.',
      'onboard_stat_1_val_3': 'مشفر',
      'onboard_stat_1_lbl_3': 'أمان السحاب',
      'onboard_stat_2_val_3': 'بنقرة واحدة',
      'onboard_stat_2_lbl_3': 'تصدير التقارير',

    },

      'hi': {
        // General & App
        'app_name': 'मुनाफ़ा',
        'app_subtitle': 'व्यापार एवं लाभ ट्रैकर',
        'loading': 'लोड हो रहा है...',
        'skip': 'छोड़ें',
        'next': 'आगे',
        'get_started': 'शुरू करें',
        'back': 'पीछे',
        'select_language': 'भाषा चुनें',
        'choose_preferred_language': 'जारी रखने के लिए अपनी पसंदीदा भाषा चुनें',
        'confirm': 'पुष्टि करें',

        // Languages
        'lang_en': 'English (अंग्रेज़ी)',
        'lang_ur': 'اردو (उर्दू)',
        'lang_ar': 'العربية (अरबी)',
        'lang_hi': 'हिन्दी',


        // Splash
        'splash_tagline': 'निवेश  •  ट्रैक  •  विकास',
        'splash_subtagline': 'बढ़ते व्यवसायों के लिए स्मार्ट वित्तीय प्रबंधन',

        // Onboarding Slide 1
        'onboard_badge_1': 'स्मार्ट ट्रैकिंग',
        'onboard_title_1': 'आय और व्यय का सहज हिसाब',
        'onboard_desc_1': 'दैनिक लेनदेन, बिक्री रसीदें और व्यापारिक नकदी प्रवाह को सेकंडों में स्पष्ट और पारदर्शी रिपोर्ट के साथ दर्ज करें।',
        'onboard_stat_1_val': '100%',
        'onboard_stat_1_lbl': 'सटीक रिकॉर्ड',
        'onboard_stat_2_val': 'तत्काल',
        'onboard_stat_2_lbl': 'कैशफ्लो सिंक',

        // Onboarding Slide 2
        'onboard_badge_2': 'मुनाफ़ा विश्लेषण',
        'onboard_title_2': 'रीयल-टाइम लाभ और मार्जिन अंतर्दृष्टि',
        'onboard_desc_2': 'सहज विज़ुअल डैशबोर्ड के माध्यम से अपने वास्तविक मार्जिन, शीर्ष उत्पाद और लाभ के रुझानों को समझें।',
        'onboard_stat_1_val_2': '+35%',
        'onboard_stat_1_lbl_2': 'औसत वृद्धि',
        'onboard_stat_2_val_2': '24/7',
        'onboard_stat_2_lbl_2': 'लाइव रिपोर्ट',

        // Onboarding Slide 3
        'onboard_badge_3': 'व्यापार विकास',
        'onboard_title_3': 'विश्वास के साथ अपना व्यवसाय बढ़ाएं',
        'onboard_desc_3': 'स्वचालित वित्तीय सारांश, पीडीएफ निर्यात और बहु-मुद्रा बहीखाते के साथ अपने व्यापार को सशक्त बनाएं।',
        'onboard_stat_1_val_3': 'सुरक्षित',
        'onboard_stat_1_lbl_3': 'क्लाउड सुरक्षा',
        'onboard_stat_2_val_3': '1-क्लिक',
        'onboard_stat_2_lbl_3': 'रिपोर्ट निर्यात',
      },
    };

    String translate(String key) {
      return localizationValues[locale.languageCode]?[key] ??
             localizationValues['en']?[key]??
             key;
    }
  }

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();


  @override
  bool isSupported(Locale locale) =>
     ['en', 'ur', 'ar', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale)async {
    return AppLocalization(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
  }
  class AppTranslation extends Translations {
    @override
    Map<String, Map<String, String>> get keys => AppLocalization.localizationValues;
  }






  


