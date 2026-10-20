# Submission Checklist — Operation Sentinel Web

## The 3 required proofs (mapping to files/URLs)

| Proof | Delivered File | Location / Access |
|-------|----------------|-------------------|
| 1. System configuration evidence (sentinel user, log dir, service) | phase1_evidence.txt | `~/sentinel-web/deliverables/phase1_evidence.txt` |
| 2. Docker deployment evidence (container serving dashboard) | phase2_evidence.txt | `~/sentinel-web/deliverables/phase2_evidence.txt` |
| 3. GitHub Actions evidence (lint + docker-build jobs green) | phase3_evidence.txt | `~/sentinel-web/deliverables/phase3_evidence.txt` and GitHub Actions run [this URL](https://github.com/DivineUI/sentinel-web/actions/runs/39468395692) |

## Repo / Actions status

- Repo:  `https://github.com/DivineUI/sentinel-web` (branch `main`)
- Workflow file: `.github/workflows/main.yml`
- CI run: `https://github.com/DivineUI/sentinel-web/actions/runs/39468395692`
- Jobs: `lint` (completed success) and `docker-build` (completed success)

## File tree

```
sentinel-web/
├── Dockerfile
├── monitor.sh
├── .github/workflows/main.yml
├── README.md
└── deliverables/
    ├── docker_run.sh
    ├── phase1_evidence.txt
    ├── phase2_evidence.txt
    ├── phase3_evidence.txt
    ├── SUBMISSION_CHECKLIST.md
    └── setup_all.sh
```
