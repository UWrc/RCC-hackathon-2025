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

lazy_prompt = "Write a Python class for a bank account"

print("Lazy Prompt Result:\n")
print(generate(lazy_prompt, temperature=0.7))


structured_prompt = '''
Goal: Generate production-ready Python code for a bank account class.
Task: Implement a `BankAccount` class with the following features:
- Constructor that takes an initial balance (default: 0)
- deposit(amount): increases balance
- withdraw(amount): decreases balance with error handling
- get_balance(): returns current balance
- Raise exceptions for invalid transactions (e.g., overdraft, negative input)

Constraints:
- Use Python 3
- No print statements
- Do not include explanations or comments
- Return only code, no markdown formatting

Audience: This code will be automatically tested in a backend system.

<START>
class BankAccount:
'''

print("\nStructured Prompt Result:\n")
print(generate(structured_prompt, temperature=0.7))
