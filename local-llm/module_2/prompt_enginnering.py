import torch
from transformers import AutoModelForCausalLM, AutoTokenizer

local_model_path = "/gscratch/stf/hackathon/llm/mistral_7b"

tokenizer = AutoTokenizer.from_pretrained(local_model_path)
model = AutoModelForCausalLM.from_pretrained(
    local_model_path,
    device_map="auto",        # Automatically map model to available GPUs
    torch_dtype="auto"        # Use model's default precision
)

def generate(prompt, temperature=0.7, top_p=0.95, max_new_tokens=150):
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    with torch.no_grad():
        output = model.generate(
            **inputs,
            max_new_tokens=max_new_tokens,
            temperature=temperature,
            top_p=top_p,
            do_sample=True
        )
    return tokenizer.decode(output[0], skip_special_tokens=True)

prompts = [
    "What is artificial intelligence?",
    "Explain artificial intelligence in simple terms for a high school student.",
    "Define AI in one sentence.",
    "Give me a poetic description of what AI means to humanity.",
    "Imagine you are a philosopher: what is your view on AI?"
]

for i, prompt in enumerate(prompts):
    print(f"\n--- Prompt {i+1} ---\n{prompt}\n")
    print(generate(prompt))
