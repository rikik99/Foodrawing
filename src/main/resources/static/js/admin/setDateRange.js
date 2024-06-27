function setDateRange(range, dateGroupName) {
    const today = new Date();
    let startDate, endDate;

    switch (range) {
        case 'today':
            startDate = endDate = today.toISOString().split('T')[0];
            break;
        case 'yesterday':
            today.setDate(today.getDate() - 1);
            startDate = endDate = today.toISOString().split('T')[0];
            break;
        case 'week':
            endDate = today.toISOString().split('T')[0];
            today.setDate(today.getDate() - 7);
            startDate = today.toISOString().split('T')[0];
            break;
        case 'month':
            endDate = today.toISOString().split('T')[0];
            today.setMonth(today.getMonth() - 1);
            startDate = today.toISOString().split('T')[0];
            break;
        case '3months':
            endDate = today.toISOString().split('T')[0];
            today.setMonth(today.getMonth() - 3);
            startDate = today.toISOString().split('T')[0];
            break;
        case 'all':
            startDate = endDate = '';
            break;
    }

    const startDateInput = document.querySelector(`input[name="${dateGroupName}_fr_date"]`);
    const endDateInput = document.querySelector(`input[name="${dateGroupName}_to_date"]`);

    if (startDateInput && endDateInput) {
        startDateInput.value = startDate;
        endDateInput.value = endDate;
    }
}
