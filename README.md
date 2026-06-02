# 🐦 PigeonSec Blocklists

## Status

These lists are no longer updated automatically.

The dedicated update server was shut down because it cost too much to keep running. Until a cheaper replacement exists, this repository should be treated as a manual / best-effort snapshot rather than a continuously refreshed feed.

Two blocklists, freshly pecked, cleaned, and de-wormed by a flock of cyber-pigeons:

| File | Description | Raw Link |
|------|--------------|-----------|
| **🦠 `bad.txt`** | Malware, phishing, C2s, and other crumb-stealing nasties. | [🔗 View Raw](https://raw.githubusercontent.com/PigeonSec/blocklists/refs/heads/main/bad.txt) |
| **💩 `annoying.txt`** | Trackers, miners, pop-ups, and other digital pigeons. | [🔗 View Raw](https://raw.githubusercontent.com/PigeonSec/blocklists/refs/heads/main/annoying.txt) |


Both are still usable with **Pi-hole**, **AdGuard Home**, or any DNS blocker that eats plain text, but they may now become stale over time.

---

## ⚙️ Usage

1. Download either or both `.txt` lists.  
2. Import them into:
   - 🧩 **Pi-hole** (`Settings → Adlists`)
   - 🧱 **AdGuard Home** (`Filters → DNS blocklists`)
   - or any tool that supports newline-separated domain lists.

Each line is a verified domain — no wildcards, no regex, just clean crumbs.

---

## 🧠 How They’re Made

These aren’t random breadcrumbs — they’re hand-validated by our in-house super-bird:  
👉 [**Magpie**](https://github.com/PigeonSec/magpie)

Magpie uses the supplied list of blocklist URLs:
- 🪶 Downloads dozens of public blocklists  
- 🧹 Deduplicates domains  
- 🔍 Validates each one via DNS resolution (A, AAAA or CNAME)
- ⚡ Shrinks the noise by **~70%** - only keeping live, resolvable domains  

### 🐢 Extended Validation (Optional)

For slower, deeper cleaning, Magpie can perform **HTTP validation** on live domains.  
This checks not just if a domain resolves — but whether it actually hosts a live threat page.

Result: compact, high-quality blocklists with less noise and more bite.

---


Made with crumbs, caffeine, and questionable bird noises by PigeonSec.

"Grrrrrruuuuuhhhh!!!!" PigeeeooonnSeeeeeec!!!
