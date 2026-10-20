# Moha Hotel Pro — Nidaamka Maamulka Hoteelka

Nooc bilow ah oo leh login/password, qolal, boos celin, marti, lacag-bixin, shaqaale/roles, iyo warbixinno. UI-gu waa Af-Soomaali, database-kuna waa Supabase (Postgres + Auth).

## Sida loo kiciyo

1. Samee project bilaash ah gudaha [Supabase](https://supabase.com/).
2. Fur **SQL Editor** gudaha project-ka, samee query cusub, kuna dheji dhammaan waxa ku jira `schema.sql`, kadibna riix **Run**.
3. Supabase Project Settings → **API** (ama Connect) ka qaado **Project URL** iyo **public anon/publishable key**. WALIGAA ha isticmaalin `service_role` key gudaha browser.
4. Fur `app.js`, beddel `SUPABASE_URL` iyo `SUPABASE_ANON_KEY` placeholders.
5. Ku daabac GitHub Pages: repository Settings → Pages → Deploy from a branch → branch `main`; dooro folder `/ (root)` kaliya haddii aad nuqulka app-ka u soo guuriso root. Haddii aad ku hayso `hotel-pro/`, isticmaal workflow deployment ku habboon folder-kaas ama adeeg sida Netlify oo `hotel-pro` ka dhig publish directory.
6. Fur `hotel-pro/index.html` si aad u aragto qaabka; login-ku wuxuu shaqaynayaa oo keliya marka Supabase la habeeyo. Supabase Auth settings waxay ku oggolaan karaan email confirmation; haddii ay daaran tahay, xaqiiji email-kaaga ka hor login.
7. Akoonka ugu horreeya wuxuu ku bilaabmaa role `staff`. Marka aad hubiso email-ka maamulaha, Supabase SQL Editor ku socodsii:
   `update public.profiles set role='owner' where email='EMAIL-KAAGA';`
   Ku beddel email-kaaga dhabta ah.

## Faylasha

- `index.html` — interface-ka responsive.
- `app.js` — login iyo hawlaha database-ka.
- `schema.sql` — tables, RLS policies, profile trigger, qolal tijaabo ah.

## Xogta iyo amniga

- Database-ka wuxuu ku jiraa Supabase, sidaas darteed shaqaalaha la oggolaaday waxay heli karaan xogta iyagoo qalab kala duwan isticmaalaya.
- Kani waa starter, mana aha nidaam production oo si buuxda loo audit-gareeyey. Kahor isticmaalka hoteel dhab ah: adkee RLS policies si role kasta loogu xaddido hawlihiisa; ku dar xaqiijinta isku-dhaca booking dates; samee check-in/check-out iyo audit logs; isticmaal lacag-bixin transactions oo la xaqiijiyo; samee backups.
- Policies-ka bilowga ah waxay u oggolaanayaan user kasta oo login ah inuu wax ka beddelo qolalka iyo bookings-ka; ha u adeegsan xog xasaasi ah ama ganacsi dhab ah ilaa permissions-ka la adkeeyo.
- Browser-ku wuxuu isticmaalaa oo keliya public anon/publishable key. Waligaa ha gelin service-role key HTML/JS ama GitHub.
