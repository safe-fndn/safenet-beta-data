# CLAUDE.md — safenet-data

Guidelines for working on this repository with Claude.

## Repository purpose

This repo stores and serves JSON data for Safenet Beta, Safenet Aegis, and potentially future Safenet versions: network-level stats, validator info, and rewards distribution data. It is consumed by frontends and other tooling that rely on stable file paths and predictable schemas.

## Key files

- `assets/network-info.json` — aggregate network stats (staked SAFE, total transactions checked)
- `assets/validator-info.json` — per-validator data
- `assets/rewards/` — merkle proofs and distribution data for SafeDAO-approved rewards proposals

## Data integrity rules

- **Never break existing JSON schemas.** Consumers depend on field names and types being stable. Adding new optional fields is fine; removing or renaming fields is a breaking change.
- **Validate JSON before committing.** All JSON files must be valid and well-formed. Use `python3 -m json.tool <file>` or `jq . <file>` to verify.
- **Keep numeric types stable.** Never change a field between JSON number and string. `total_staked_amount` is a decimal string with up to 18 decimal places, and token amounts in `assets/rewards/` are integer strings, so large values stay exact. Other numeric fields, such as `total_transactions_checked`, `commission` and `participation_rate_14d`, are JSON numbers.
- **Monotonic counters must never decrease.** `total_transactions_checked` only goes up within a Safenet version; never write a lower value than what is already present for that version.
- **Preserve decimal precision.** `total_staked_amount` supports up to 18 decimal places; do not round unless explicitly instructed.

## Update cadence

- `assets/network-info.json` — auto-updated every 3h by the `Update Safenet Data` workflow (`.github/workflows/update-data.yml`).
- `assets/validator-info.json` — only `participation_rate_14d` is auto-updated by the same workflow. `label`, `commission` and `is_active` are edited manually. New validators are added by the workflow with only `address` and `participation_rate_14d`; fill in the remaining fields manually.
- `assets/rewards/` — updated manually, following an approved SafeDAO rewards distribution proposal only.

## On-chain sources

| Data | Contract | Network |
|------|----------|---------|
| `total_staked_amount` | [`0x115E78f160e1E3eF163B05C84562Fa16fA338509`](https://etherscan.io/address/0x115E78f160e1E3eF163B05C84562Fa16fA338509#code) | Ethereum mainnet |
| `total_transactions_checked` | [`0x223624cBF099e5a8f8cD5aF22aFa424a1d1acEE9`](https://gnosisscan.io/address/0x223624cBF099e5a8f8cD5aF22aFa424a1d1acEE9) (Safenet Beta) | Gnosis Chain |

## Commit hygiene

- Keep commits focused: one logical change per commit.
- Commit messages should state what changed and why (e.g. `chore: update network-info.json with latest staking snapshot`).
- Do not commit secrets, private keys, or internal infrastructure URLs.
