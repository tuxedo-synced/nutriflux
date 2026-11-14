
package org.springframework.foodwastemanagement.sevice.implementation;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.foodwastemanagement.helper.EmailTableData;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender javaMailSender;
    @Value("${MAIL_USERNAME}")
    String fromEmail ;

    public void sendExpiryMail(
            String to,
            List<EmailTableData> emailTableDataList
    ) throws Exception {

        StringBuilder table = new StringBuilder();

        table.append("""
            <table style="width:100%;border-collapse:collapse;">
                <tr style="background-color:#263b50;color:white;">
                    <th style="padding:12px;border:1px solid #ddd;">
                        Product Name
                    </th>
                    <th style="padding:12px;border:1px solid #ddd;">
                        Days Remaining
                    </th>
                </tr>
            """);

        for (EmailTableData data : emailTableDataList) {

            table.append("<tr>")
                    .append("<td style='padding:10px;border:1px solid #ddd;'>")
                    .append(data.getProductName())
                    .append("</td>")
                    .append("<td style='padding:10px;border:1px solid #ddd;'>")
                    .append(data.getDaysLeft())
                    .append("</td>")
                    .append("</tr>");
        }

        table.append("</table>");

        String html = """
            <html>
            <body style="font-family:Arial,sans-serif;color:#333;">
                <h2 style="color:#263b50;">
                    NutriFlux - Product Expiry Alert
                </h2>

                <p>Hello!</p>

                <p>The following products are nearing their expiry dates:</p>

                %s

                <p>Please take the necessary action to prevent food waste.</p>

                <p>Regards,<br><b>Team NutriFlux</b></p>
            </body>
            </html>
            """.formatted(table);

        MimeMessage message = javaMailSender.createMimeMessage();

        MimeMessageHelper helper =
                new MimeMessageHelper(message, true, "UTF-8");


        helper.setFrom(fromEmail);
        helper.setTo(to);
        helper.setSubject("NutriFlux - Product Expiry Alert");
        helper.setText(html, true);

        javaMailSender.send(message);
    }

}
