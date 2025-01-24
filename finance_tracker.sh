#!/bin/bash

EXPENSES_LOG="$HOME/expense.log"

# Ensure the expense log file exists
if [ ! -f "$EXPENSES_LOG" ]; then
    touch "$EXPENSES_LOG"
fi

# Function to display the menu
show_menu() {
    echo "==========================="
    echo "   PERSONAL FINANCE TRACKER"
    echo "==========================="
    echo "1. Add Expense"
    echo "2. View Expenses"
    echo "3. Calculate Total Expenses"
    echo "4. Exit"
    echo "==========================="
}

# Function to add an expense
add_expense() {
    read -p "Enter the expense description: " DESCRIPTION
    read -p "Enter the expense amount: " AMOUNT
    
    # Get the current date in MM,DD,YYYY format
    CURRENT_DATE=$(date +"%m,%d,%Y")
    
    # Log the expense to the log file
    echo "$CURRENT_DATE, \$${AMOUNT}, $DESCRIPTION" >> "$EXPENSES_LOG"
    echo "Expense added successfully!"
}

# Function to view all expenses
view_expenses() {
    echo "==========================="
    echo "       EXPENSE LOG         "
    echo "==========================="
    if [ -s "$EXPENSES_LOG" ]; then
        cat "$EXPENSES_LOG"
    else
        echo "No expenses recorded."
    fi
}

# Function to calculate total expenses
calculate_total() {
    TOTAL=0
    while IFS=',' read -r DATE AMOUNT DESCRIPTION; do
        AMOUNT=$(echo "$AMOUNT" | tr -d '$ ')  # Remove the dollar sign and spaces
        TOTAL=$(echo "$TOTAL + $AMOUNT" | bc)
    done < "$EXPENSES_LOG"
    echo "Total Expenses: \$${TOTAL}"
}

# Main loop
while true; do
    show_menu
    read -p "Choose an option (1-4): " OPTION
    case $OPTION in
        1)
            add_expense
            ;;
        2)
            view_expenses
            ;;
        3)
            calculate_total
            ;;
        4)
            echo "Exiting Finance Tracker. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose between 1 and 4."
            ;;
    esac
    echo
done
