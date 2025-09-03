```
k8s-secure-gateway-lab/
│
├── infra/                 
│   ├── terraform/         
│   └── helm/             
│
├── apps/                  
│   ├── blog/             
│   ├── model-api/         
│   ├── notes/            
│   └── lab-insecure/      
│
├── policies/              # Security policies
│   ├── rbac/              # RBAC YAMLs
│   ├── network-policies/  # NetworkPolicy YAMLs
│   ├── pod-security/      # PSS/Kyverno/Gatekeeper configs
│   └── secrets/           # External Secrets or SOPS templates
│
├── observability/         # Monitoring & alerts
│   ├── prometheus/        
│   ├── grafana-dashboards/
│   ├── loki/
│   └── falco/
│
├── docs/                  # Documentation
│   ├── diagrams/          # Architecture diagrams
│   ├── attack-vs-defense/ # Before/after results
│   └── screenshots/       # Grafana, Falco alerts, terminal output
│
├── .github/workflows/     # GitHub Actions for CI/CD
│
├── README.md              # Main project doc
└── LICENSE
```

# k8s-secure-gateway-lab

A secure API gateway on Kubernetes — built as both a **home for my apps** and a **security lab** where I practice Red Team vs Blue Team scenarios.

---

## 🚀 What this is
- Central **API Gateway** (Ingress + OIDC auth) for all my apps:
  - `/blog`
  - `/model-api`
  - `/notes`
- Includes a **deliberately weak app** for practicing attacks.
- Step by step, I secure it with:
  - RBAC
  - NetworkPolicies
  - Pod Security
  - Service mesh mTLS
  - Observability (Prometheus, Grafana, Loki, Falco)

---

## 🗂️ Project Structure
- `infra/` → Terraform + Helm for infra and services
- `apps/` → Applications (blog, model-api, notes, insecure lab)
- `policies/` → RBAC, NetworkPolicies, PodSecurity
- `observability/` → Monitoring + alerts
- `docs/` → Diagrams, attack/defense results, screenshots

---

## 📖 Roadmap
- [ ] Phase 1: Cluster, domain, TLS
- [ ] Phase 2: Gateway + OIDC login
- [ ] Phase 3: Deploy real apps
- [ ] Phase 4: Insecure app + attacks
- [ ] Phase 5: Security hardening
- [ ] Phase 6: Observability + alerts
- [ ] Phase 7: Re-attack & prove defenses
- [ ] Phase 8: Docs + blog posts

---

## 🔑 Skills I’m building
- Kubernetes networking & Ingress
- API Gateway security (OIDC, TLS, rate limiting)
- Kubernetes security (RBAC, NetworkPolicies, Pod Security, mTLS)
- Observability & incident response (Prometheus, Grafana, Loki, Falco)
- IaC + CI/CD for infra and policies

---

## 📸 Attack vs Defense (coming soon)
Screenshots & logs of attacks that worked before… and how they failed after hardening.
