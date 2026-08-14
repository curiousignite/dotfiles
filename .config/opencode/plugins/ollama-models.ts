import type { Plugin } from "@opencode-ai/plugin"

// Ollama server address — respects OLLAMA_HOST like the ollama CLI does.
const OLLAMA_BASE = (process.env.OLLAMA_HOST ?? "http://localhost:11434").replace(/\/+$/, "")

const TIMEOUT_MS = 2000

async function fetchOllamaModels(): Promise<Record<string, { name: string }>> {
  const controller = new AbortController()
  const timer = setTimeout(() => controller.abort(), TIMEOUT_MS)
  try {
    const res = await fetch(`${OLLAMA_BASE}/api/tags`, { signal: controller.signal })
    if (!res.ok) return {}
    const data = (await res.json()) as { models?: Array<{ name: string }> }
    const models: Record<string, { name: string }> = {}
    for (const m of data.models ?? []) {
      models[m.name] = { name: friendlyName(m.name) }
    }
    return models
  } catch {
    // Ollama not running / unreachable — fail silently, opencode works without it.
    return {}
  } finally {
    clearTimeout(timer)
  }
}

function friendlyName(id: string): string {
  const base = id.split("/").pop() ?? id
  // Strip quantization suffixes: q4_k_s, q4ks, Q4_K_S, q8_0 …
  const cleaned = base.replace(/[-:](?:q\d+(?:_[a-z0-9]+)*|Q\d+(?:_[A-Z0-9]+)*)$/i, "")
  return cleaned
    .replace(/[-_:]/g, " ")
    .replace(/\s+/g, " ")
    .trim()
    .replace(/\b\w/g, (c) => c.toUpperCase())
}

export const OllamaModels: Plugin = async () => {
  // Fetch the model list BEFORE returning hooks, so the data is ready
  // when opencode invokes the config hook.
  const models = await fetchOllamaModels()

  return {
    config: (cfg) => {
      const ollama = (cfg.provider ??= {}).ollama ??= {
        npm: "@ai-sdk/ollama",
        options: { baseURL: `${OLLAMA_BASE}/api` },
      }
      const existing = (ollama.models ??= {})
      for (const [id, info] of Object.entries(models)) {
        // Preserve any models the user configured manually; only add new ones.
        if (!existing[id]) existing[id] = info
      }
    },
  }
}

export default OllamaModels