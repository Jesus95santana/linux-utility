#!/bin/zsh
# This uses a zsh-specific feature: floating-point arithmetic
function zsh_test() {
    float a=10.5 b=3.25
    if (( a + b > 0 )); then
        echo $(( a + b ))
        echo "✅ Passed"
    else
        echo "❌ Failed"
    fi
}