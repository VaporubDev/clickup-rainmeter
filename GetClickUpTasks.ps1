param(
    [Parameter(Mandatory = $true)]
    [string]$ApiToken,
    [Parameter(Mandatory = $true)]
    [string]$ListId,
    [ValidateSet('done', 'todo')]
    [string]$Mode = 'todo'
)

if ([string]::IsNullOrWhiteSpace($ApiToken) -or
    $ApiToken -like 'COLOQUE_SEU_*' -or
    [string]::IsNullOrWhiteSpace($ListId) -or
    $ListId -like 'COLOQUE_SEU_*') {
    'Configure APIToken e ListID no ClickUp.ini'
    exit 0
}

try {
    $headers = @{ Authorization = $ApiToken }
    $uri = "https://api.clickup.com/api/v2/list/$ListId/task?include_closed=true&subtasks=true"
    $response = Invoke-RestMethod -Uri $uri -Headers $headers -TimeoutSec 10
    $tasks = @($response.tasks)

    if ($Mode -eq 'done') {
        $tasks = @($tasks | Where-Object {
            $_.status.type -in @('closed', 'done') -or
            $_.status.status -like '*conclu*' -or
            $_.status.status -eq 'complete'
        } | Select-Object -First 3)
        $emptyMessage = 'Sem tarefas concluidas'
    } else {
        $tasks = @($tasks | Where-Object {
            $_.status.type -notin @('closed', 'done') -and
            $_.status.status -notlike '*conclu*' -and
            $_.status.status -ne 'complete'
        } | Select-Object -First 6)
        $emptyMessage = 'Sem tarefas pendentes'
    }

    if ($tasks.Count -eq 0) {
        $emptyMessage
        exit 0
    }

    foreach ($task in $tasks) {
        if ($task.due_date) {
            $date = [DateTimeOffset]::FromUnixTimeMilliseconds([int64]$task.due_date).ToLocalTime().ToString('dd/MM')
        } else {
            $date = '-'
        }

        if ($task.priority.priority) {
            $priority = $task.priority.priority.ToUpper()
        } else {
            $priority = '-'
        }

        $name = [string]$task.name
        if ($name.Length -gt 24) {
            $name = $name.Substring(0, 21) + '...'
        }

        '{0,-26} {1,-7} {2,-6}' -f $name, $date, $priority
    }
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode) {
        "Erro API HTTP $statusCode"
    } else {
        'Erro de conexao com o ClickUp'
    }
}
