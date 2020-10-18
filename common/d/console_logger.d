module common.console_logger;

import std.experimental.logger;
import common.console;
import std.stdio : File;

class ConsoleLogger : FileLogger
{
    private Console* console;
    private File f;
    this(File file, LogLevel lv = LogLevel.all)
    {
        f = file;
        console = Console.create(file);
        super(file, lv);
    }

    protected override @safe void writeLogMsg(ref LogEntry payload)
    {
        switch (payload.logLevel)
        {
        case LogLevel.error:
            console.setColor(Color.red);
            break;
        case LogLevel.critical:
        case LogLevel.fatal:
            console.setColor(Color.brightRed);
            break;
        case LogLevel.trace:
            console.setColor(Color.black);
            break;
        case LogLevel.warning:
            console.setColor(Color.yellow);
            break;
        case LogLevel.info:
            console.setColor(Color.green);
            break;
        default:
            break;
        }
        super.writeLogMsg(payload);
        console.setColor(Color.lightGray);
    }
}
