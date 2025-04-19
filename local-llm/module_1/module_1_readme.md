# Module 1: Mini GPT-style Transformer
---

## Contents

1. [Vocabulary Setup](#vocab)
2. [Causal Attention Mask](#mask)
3. [Transformer Model](#transformer)
4. [Text Generation](#generation)
5. [Visualization](#visuals)

---

## <a name="vocab"></a>1. Vocabulary Setup

We define a small list of words for the model to work with.

- **`stoi` (string-to-index)**: Maps words like `"hello"` to numbers like `3`.
- **`itos` (index-to-string)**: Reverses the mapping for generation output.

The model only "knows" the tokens in this vocabulary — no subword tokenization, no special tricks.

---

## <a name="mask"></a>2. Causal Attention Mask

Transformers can look at all tokens at once. But GPT models are **causal** — they can only attend to earlier tokens.

We use a **causal mask**:
```
1  -inf  -inf
1    1   -inf
1    1     1
```

This prevents the model from "peeking" into the future.

---

## <a name="transformer"></a>3. Transformer Model

We build a simplified GPT using:

- `nn.Embedding`: Turns token IDs into vectors
- `nn.Parameter`: Learnable positional encoding
- `nn.TransformerEncoderLayer`: One layer of attention + feedforward
- `nn.TransformerEncoder`: Stacks multiple layers
- `nn.Linear`: Projects back to vocabulary logits

We replace `TransformerEncoderLayer` with a custom version that exposes **attention weights** for visualization.

---

## <a name="generation"></a>4. Text Generation

We start with a **prompt** like `["<bos>", "hello"]` and generate tokens one-by-one.

### Temperature Sampling
- The logits are scaled by temperature.
- Then `softmax()` gives us a probability distribution.
- We sample from the distribution using `torch.multinomial`.

⚠️ Low probability tokens can still be picked — this makes output creative, but not always optimal.

---

## <a name="visuals"></a>5. Visualizations

### Logits vs Probabilities
We plot the top predictions at each generation step:

- **Logits**: Raw model scores (can be negative or very large)
- **Softmax**: Turned into probabilities
- Helps understand why a token was chosen

---

## <a name="topk"></a>6. Top-k Sampling

The default sampling uses the full distribution.

With **Top-k**, we:
- Take only the `k` highest logits
- Zero out all others
- Sample **only from those**

This is more controlled and avoids strange low-probability tokens.

---

## Summary

This notebook helps you understand:
- How LLMs are built layer by layer
- How sampling actually works
- How attention influences predictions

From here, you can:
- Add top-p (nucleus) sampling
- Train the model on small data
- Expand the vocabulary
- Use a real tokenizer like SentencePiece or BPE

Happy tinkering!
